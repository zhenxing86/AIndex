USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetCountBytime]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
          
------------------------------------          
--用途：查询文档列表数量记录信息           
--项目名称：ZGYEYBLOG          
--说明：          
--时间：2008-10-03 21:30:07          
--作者：along          
--exec  thelp_documents_GetCountBytime  8,0,'1900-01-01','2900-01-01','' ,1        
------------------------------------          
CREATE PROCEDURE [dbo].[thelp_documents_GetCountBytime]          
@categoryid int,          
@level int,          
@firsttime datetime,          
@lasttime datetime,          
@title varchar(100),  
@getsubcategory int =1          
          
 AS          
DECLARE @TempID int          
          
if(@firsttime = '')          
BEGIN          
set @firsttime=convert(datetime,'1900-01-01')          
End          
          
          
if(@lasttime = '')          
BEGIN          
set @lasttime=convert(datetime,'2090-01-01')          
End          
          
 IF(@level=0)          
 BEGIN          
  DECLARE @categorytb TABLE          
 (          
  --定义临时表          
  row int IDENTITY (1, 1),          
  categoryid int,      
  [Level] int      
 )        
 declare @categoryLevel int=1         
  declare @categorycountflag int      
 -- 获取本身和下级分类列表 开始            
 INSERT @categorytb SELECT @categoryid,@categoryLevel   
 if(@getsubcategory=1)     
 begin  
 WHILE @@ROWCOUNT>0      
 BEGIN      
  SET @categoryLevel=@categoryLevel+1      
  INSERT @categorytb SELECT a.categoryid,@categoryLevel      
  FROM thelp_categories a,@categorytb b      
  WHERE a.parentid=b.categoryid and a.[status]=1      
   AND b.Level=@categoryLevel-1      
   END     
  end    
 --获取本身和下级分类列表 结束      
  SELECT @TempID = count(1) FROM thelp_documents WHERE deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and categoryid in(select categoryid from @categorytb)          
           
 END          
          
 ELSE IF (@level=1)          
  BEGIN          
   SELECT @TempID = count(1) FROM thelp_documents WHERE deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and categoryid=@categoryid          
  END          
          
 ELSE IF (@categoryid=-1)          
  BEGIN          
   SELECT @TempID = count(1) FROM thelp_documents WHERE deletetag=1 and  createdatetime >@firsttime and createdatetime <= @lasttime and title like '%'+@title+'%' and userid=@level  and categoryid in(select categoryid from thelp_categories where userid=@level and status=1)        
  END          
          
 RETURN @TempID 
GO
