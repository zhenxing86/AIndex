USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_blog_class_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- exec [kweb_blog_class_GetList] 25264,1,50,'小班'
CREATE PROCEDURE [dbo].[kweb_blog_class_GetList]   
@kid int,    
@page int,    
@size int,    
@caption nvarchar(30)    
AS     
BEGIN    
if(exists(select 1 from theme_kids where kid=@kid))    
begin    
 SET @kid=12511    
end    
    
 IF(@page>1)    
 BEGIN    
  DECLARE @count int    
  DECLARE @ignore int    
  SET @count=@page*@size    
  SET @ignore=@count-@size    
  DECLARE @tempTable TABLE    
  (    
   row int identity(1,1) primary key,    
   tempid int    
  )      
  SET ROWCOUNT @count    
  INSERT INTO @tempTable SELECT t1.cid FROM BasicData..class t1     
  LEFT JOIN basicdata..grade t3 ON t1.grade=t3.gid    
  WHERE t1.deletetag=1 AND t1.kid=@kid     
  AND t3.gname=@caption    
  ORDER BY t3.[order] asc, t1.[order] desc     
    
  SELECT cid,cname,siteid    
  FROM basicdata..class t1    
  JOIN @tempTable t2 ON t1.cid=t2.tempid    
  JOIN blog_classlist t3 ON t1.cid=t3.classid     
  WHERE tempid=t1.cid AND row>@ignore    
  ORDER BY t1.[order] desc    
 END    
 ELSE    
 BEGIN    
  SET ROWCOUNT @size    
  SELECT t1.cid,t1.cname,siteid FROM basicdata..class t1    
  JOIN basicdata..grade t3 ON t1.grade=t3.gid    
  JOIN blog_classlist t2 ON t1.cid=t2.classid   
  WHERE t1.deletetag=1  AND t1.kid=@kid     
  AND t3.gname=@caption    
  ORDER BY t3.[order] asc, t1.[order] desc     
 END    
END    
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_blog_class_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
