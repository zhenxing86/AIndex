USE [BackupApp]
GO
/****** Object:  StoredProcedure [dbo].[BackUpTable]    Script Date: 2014/11/24 21:16:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-26
-- Description:	备份表
-- Memo:	
CREATE TABLE TableInfo(DBName varchar(125) NOT NULL, TBName varchar(125) NOT NULL, Keystr varchar(200) NOT NULL, FilStr varchar(2000) NOT NULL  )
INSERT INTO TableInfo(DBName, TBName, Keystr, FilStr )
SELECT 'Basicdata','user','userid', 'WHERE a.kid = @kid'
declare @result int
exec @result = BackUpTable @kid = 12511, @dbname = 'BlogApp', @TBName = 'album_categories', @VersionNo = 3
select @result
*/
CREATE PROC [dbo].[BackUpTable]
	@kid int,
	@dbname varchar(125),
	@TBName varchar(125),
	@VersionNo int
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @object_name_back varchar(125), @dbobject_name varchar(125), 
					@FilStr varchar(2000),@DelFilStr varchar(2000), @S NVARCHAR(MAX), @VersionCtrl varchar(2000) , 
					@Keystr varchar(200), @USINGStr varchar(2000), @DelExistGStr varchar(2000), @OnStr varchar(200),
					@DelOnStr varchar(200), @UpdateStr varchar(2000), @InsertStr varchar(2000) 

	SELECT	@FilStr = FilStr, @Keystr = Keystr, @VersionCtrl = VersionCtrl, 
					@DelFilStr = replace(replace(replace(replace(FilStr,']',''),'[',''),'..','_'),'.dbo.','_') 
	FROM TableInfo 
		WHERE DBName = @dbname 
			and TBName = @TBName
	IF @Keystr IS NULL
	RETURN -1		
	SET @dbobject_name = '['+@dbname + '].[dbo].['+ @TBName + ']'
	set @object_name_back = '[dbo].['+@dbname + '_' + @TBName + ']'
	SET @S = '
	IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'''+@object_name_back+''') AND type in (N''U''))
	BEGIN
		select top(0)* into '+@object_name_back+' from '+@dbobject_name+'
				cross join (select n as VersionNo from commonfun.dbo.Nums100 where n = 1)b 
	END
	'
	print @S
		EXEC SP_EXECUTESQL @S; 

  SET @S = 'Use ' + @dbname + CHAR(13) + CHAR(10) + ' 
  Declare @Alter NVARCHAR(MAX)
  Select b.Name ColName, c.name TypeName, c.length, COLUMNPROPERTY(b.id, b.name, ''PRECISION'') PREC, isnull(COLUMNPROPERTY(b.id, b.name, ''Scale''),0) Scale, b.colid Into #col 
     From sys.sysobjects a, sys.syscolumns b, sys.systypes c
    Where a.Name = ''' + @TBName + ''' and a.xType = ''U'' and a.ID = b.ID and b.xtype = c.xtype and c.status = 0
      and Not Exists (Select * From BackupApp.sys.syscolumns d Where b.name = d.name and d.ID = Object_ID(''BackupApp.dbo.' + @dbname + '_' + @TBName + '''))
  if Exists (Select * From #col)
  Begin
    Select @Alter = Isnull(@Alter + Char(13) + CHAR(10), '''') + ''Alter Table BackupApp.dbo.[' + @dbname + '_' + @TBName + '] Add ['' + ColName + ''] '' + TypeName + 
    Case When length = 8000 Then ''(max)'' When TypeName In (''Char'', ''Varchar'', ''NVarchar'') Then + ''('' + Cast(length as Varchar) + '')'' When TypeName In (''numeric'') Then ''('' + Cast(PREC as Varchar) + '', '' + Cast(Scale as Varchar) + '')'' Else '''' End
      From #col Order by colid
    Exec(@Alter)
  End  
  Drop Table #col'
  
  Print @S
		EXEC SP_EXECUTESQL @S; 
  
	select @USINGStr = 'SELECT ' + CommonFun.dbo.sp_GetSumStr('a.['+name+'],' ) + ' @VersionNo [VersionNo]
		FROM '+@dbobject_name+' a 
		' + @FilStr 
		from sys.columns 
		where object_id = object_id(@object_name_back) 
			and name <> 'VersionNo'
	select @DelExistGStr = 'SELECT 1
						FROM '+@dbobject_name+' ai 
						' + REPLACE(@FilStr,' a.',' ai.') 
		from sys.columns 
		where object_id = object_id(@object_name_back) 
			and name <> 'VersionNo'
			
	select @OnStr = CommonFun.dbo.sp_GetSumStr('a.['+col+'] = b.['+col+'] and ') + 'a.[VersionNo] = b.[VersionNo]'  
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
			
	select @InsertStr = 'INSERT ('+STUFF(CommonFun.dbo.sp_GetSumStr(', ['+name+']'),1,2,'')+')
	VALUES (' +STUFF(CommonFun.dbo.sp_GetSumStr(', a.['+name+']'),1,2,'') + ')'
		from sys.columns 
		where object_id = object_id(@object_name_back) 
		
	SET @S = '
	;MERGE '+@object_name_back+' AS b
	USING 
	(	
		'+@USINGStr+'
	)AS a
	ON ('+@OnStr+')
	'+isnull(@UpdateStr,'')+'
	WHEN NOT MATCHED THEN
	'+@InsertStr+';
	'	

if OBJECTPROPERTY(OBJECT_ID(@object_name_back),'TableHasIdentity') = 1
  Set @S = 'SET IDENTITY_INSERT '+@object_name_back+' ON 
  ' + @S + '
  SET IDENTITY_INSERT '+@object_name_back+' OFF'
  
Print @S
		EXEC SP_EXECUTESQL @S,N'@kid INT, @VersionNo INT',	@kid = @kid, @VersionNo = @VersionNo; 
		
IF EXISTS( select * from BackupApp..BackupWebInfo where kid = @kid and VersionNo = @VersionNo )	
AND NOT EXISTS(SELECT * FROM BackupInnerTable a WHERE NOT EXISTS(SELECT * FROM BackupApp..TableInfo b WHERE a.DBName = b.DBName and a.TBName = b.TBName) )		
SET @S = @S + '
   	delete '+@object_name_back+' 
		from '+@object_name_back+' a 
			'+@DelFilStr+' 
			AND a.[VersionNo] = @VersionNo ' + @VersionCtrl+' 
			and not exists
				(
					'+ @DelExistGStr +'
						'+ @DelOnStr + '
				)

'

	PRINT @S
		EXEC SP_EXECUTESQL @S,N'@kid INT, @VersionNo INT',	@kid = @kid, @VersionNo = @VersionNo; 
	RETURN 1
END

GO
