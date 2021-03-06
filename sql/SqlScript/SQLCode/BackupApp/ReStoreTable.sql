USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[ReStoreTable]    Script Date: 2014/11/24 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*  
-- Author:      Master谭  
-- Create date: 2013-07-26  
-- Description: 还原表  
-- Memo:  
SELECT * FROM BASICDATA_USER_CLASS WHERE VERSIONNO = 2  
  
declare @result int  
exec @result = ReStoreTable @kid = 12511, @dbname = 'Basicdata', @TBName = 'user_CLASS', @VersionNo = 3  
select @result  
*/  
CREATE PROC [dbo].[ReStoreTable]  
 @kid int,  
 @dbname varchar(125),  
 @TBName varchar(125),  
 @VersionNo int  
AS  
BEGIN  
 SET NOCOUNT ON  
   
 DECLARE @object_name_back varchar(125), @dbobject_name varchar(125), @FilStr varchar(2000), @S NVARCHAR(MAX),   
     @Keystr varchar(200), @USINGStr varchar(2000), @OnStr varchar(2000), @UpdateStr varchar(2000),   
     @InsertStr varchar(2000), @VersionCtrl varchar(2000),@DelFilStr varchar(2000), @DelExistGStr varchar(2000),   
     @DelOnStr varchar(200), @IsCanDel BIT  
 SELECT @FilStr = replace(replace(replace(replace(FilStr,']',''),'[',''),'..','_'),'.dbo.','_'),  
     @DelFilStr = FilStr,  
     @Keystr = Keystr, @VersionCtrl = VersionCtrl,   
     @IsCanDel = IsCanDel  
 FROM TableInfo   
  WHERE DBName = @dbname   
   and TBName = @TBName  
 IF @Keystr IS NULL  
 RETURN -1    
 IF charindex('@kid',@DelFilStr) = 0  
 RETURN -1     
 SET @dbobject_name = '['+@dbname + '].[dbo].['+ @TBName + ']'  
 set @object_name_back = '[dbo].['+@dbname + '_' + @TBName + ']'  
  
 select @USINGStr = 'SELECT ' + STUFF(CommonFun.dbo.sp_GetSumStr(',a.['+name+']' ),1,1,'') + '   
  FROM '+@object_name_back+' a   
  ' + @FilStr +' AND a.[VersionNo] = @VersionNo ' + @VersionCtrl  
  from sys.columns   
  where object_id = object_id(@object_name_back)   
   and name <> 'VersionNo'     
     
 select @OnStr = STUFF(CommonFun.dbo.sp_GetSumStr('and a.['+col+'] = b.['+col+'] '),1,3,'')  
   from BasicData.dbo.f_split(@Keystr,',')  
   
 select @DelOnStr = CommonFun.dbo.sp_GetSumStr(' and a.['+col+'] = ai.['+col+'] ')   
   from BasicData.dbo.f_split(@Keystr,',')   
  
 select @UpdateStr = 'WHEN MATCHED THEN  
 UPDATE SET '+STUFF(CommonFun.dbo.sp_GetSumStr(',  
  b.['+name+'] = a.['+name+']'),1,1,'')  
  from sys.columns   
  where object_id = object_id(@object_name_back)   
   and name <> 'VersionNo'  
   and name not in(select col from BasicData.dbo.f_split(@Keystr,','))   
   and Not (name = 'id' and @dbname = 'ClassApp' and @TBName = 'class_notice_class')  
     
 select @InsertStr = 'INSERT ('+STUFF(CommonFun.dbo.sp_GetSumStr(', ['+name+']'),1,2,'')+')  
 VALUES (' +STUFF(CommonFun.dbo.sp_GetSumStr(', a.['+name+']'),1,2,'') + ')'  
  from sys.columns   
  where object_id = object_id(@object_name_back) and name <> 'VersionNo'  
    
 declare @IsIdentity bit   
   
 exec CheckIdentity  @dbname = @dbname, @TBName = @TBName, @IsIdentity = @IsIdentity output  
    
 SET @S = CASE WHEN @IsIdentity = 1 THEN '  
 SET IDENTITY_INSERT '+@dbobject_name+' ON '  
 ELSE '' END +  
' ;MERGE '+@dbobject_name+' AS b  
 USING   
 (   
  '+@USINGStr+'  
 )AS a  
 ON ('+@OnStr+')  
 '+isnull(@UpdateStr,'')+'  
 WHEN NOT MATCHED THEN  
 '+@InsertStr+'; '  
 + CASE WHEN @IsIdentity = 1 THEN '  
 SET IDENTITY_INSERT '+@dbobject_name+' OFF '  
 ELSE '' END + ';'  
 
Set @S = '
Alter Table '+@dbobject_name+' Disable Trigger All   
' + @S + '  
Alter Table '+@dbobject_name+' Enable Trigger All '  

 PRINT @S  
  EXEC SP_EXECUTESQL @S,N'@kid INT, @VersionNo INT', @kid = @kid, @VersionNo = @VersionNo;   
   
 Set @S = '  
 IF EXISTS( '+@USINGStr+' ) and '+CAST(@IsCanDel AS VARCHAR(10))+' = 1     
 delete '+@dbobject_name+'  
  FROM '+@dbobject_name+' a   
  '+@DelFilStr+'   
   and not exists  
    (  
     '+replace(replace(@USINGStr,' a.',' ai.'),' a ',' ai ')+'  
      '+ @DelOnStr + '   
    )     
      
'  
Set @S = 'Alter Table '+@dbobject_name+' Disable Trigger All   
' + @S + '  
Alter Table '+@dbobject_name+' Enable Trigger All '  
   
 PRINT @S  
  EXEC SP_EXECUTESQL @S,N'@kid INT, @VersionNo INT', @kid = @kid, @VersionNo = @VersionNo;   
 RETURN 1  
END  
GO
