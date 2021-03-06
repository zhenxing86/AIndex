USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetCountByKinDocCategoryidByTime]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      Master谭      
-- Create date: 2013-07-10      
-- Description: 查询共享幼儿园文档数      
-- Memo: 项目名称：ZGYEYBLOG 
-- 
declare  @r int
 exec @r= thelp_documents_GetCountByKinDocCategoryidByTime  89,'1900-01-01' ,'2900-01-01'  ,'',1550     
 select  @r
*/        
CREATE PROCEDURE [dbo].[thelp_documents_GetCountByKinDocCategoryidByTime]      
 @categoryid int,        
 @firsttime datetime,        
 @lasttime datetime,        
 @title varchar(100),        
 @kid int,
 @getsubcategory int=1        
AS      
BEGIN      
 SET NOCOUNT ON        
 select @title = CommonFun.dbo.FilterSQLInjection(@title)      
       
 DECLARE @TempID int        
 declare @i int,@s nvarchar(4000)      
    
 SET @s = '      
   DECLARE @categorytb TABLE        
 (        
  --定义临时表        
  row int IDENTITY (1, 1),        
  kincategoryid int,    
  [Level] int    
 )      
 declare @categoryLevel int=1      
 -- 获取本身和下级分类列表 开始          
 INSERT @categorytb SELECT @categoryid,@categoryLevel   
 if(@getsubcategory=1)
 begin
 WHILE @@ROWCOUNT>0    
 BEGIN    
  SET @categoryLevel=@categoryLevel+1    
  INSERT @categorytb SELECT a.kincategoryid,@categoryLevel    
  FROM kin_doc_category a,@categorytb b    
  WHERE a.parentid=b.kincategoryid and a.[status]=1    
   AND b.Level=@categoryLevel-1    
   END   
 end
 --获取本身和下级分类列表 结束    
     
 SELECT @TempID=count(1)       
  FROM thelp_documents       
  WHERE deletetag=1      
  and kindisplay=1 '      
 if NULLIF(@firsttime,'1900-01-01') is not null      
 SET @s = @s +  '       
  and createdatetime > @firsttime '      
 if NULLIF(@lasttime,'1900-01-01') is not null      
 SET @s = @s + '      
  and createdatetime <= @lasttime '      
 if ISNULL(@title,'') <> ''      
 SET @s = @s + '      
  and title like ''%'+@title+'%'' '       
         
 IF @categoryid>0      
 SET @s = @s + '      
  and kindoccategoryid in (select kincategoryid from @categorytb)       
 '   
  IF @kid>0      
 SET @s = @s + '      
  and kid =@kid       
 '      
 ELSE IF @categoryid<0       
 SET @s = @s + '      
  and kid = @kid '      
 --  PRINT @S     
 exec sp_executesql @s,      
           N'@TempID int OUTPUT, @categoryid int, @firsttime datetime, @lasttime datetime, @kid int,@getsubcategory int=1  ',      
           @TempID output ,@categoryid, @firsttime, @lasttime, @kid        
 RETURN @TempID        
END 
GO
