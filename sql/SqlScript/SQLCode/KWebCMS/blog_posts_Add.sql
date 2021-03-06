USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
-- =============================================  
-- Author:  hanbin  
-- Create date: 2010-01-21  
-- Description: 添加精彩文章  
-- [blog_posts_Add] 22227,924993,790147
-- =============================================  
CREATE PROCEDURE [dbo].[blog_posts_Add]  
@siteid int,  
@postid int,  
@kmpuserid int  
AS  
BEGIN  
 IF EXISTS(SELECT * FROM blog_posts WHERE siteid=@siteid AND postid=@postid)  
 BEGIN  
  RETURN 2  
 END  
 ELSE  
 BEGIN  
  if EXISTS(select * from blog_posts where siteid=0 and postid=@postid)--删除siteid=0的数据，因为如果存在相同的postid会违反约束
  begin
	delete from  blog_posts where postid=@postid and siteid=0
  end
  INSERT INTO blog_posts(siteid,postid,kmpuserid) VALUES(@siteid,@postid,@kmpuserid)    
  
  
INSERT INTO [KWebCMS].[dbo].[blog_posts_list]  
           (postid,[author]  
           ,[userid]  
           ,[postdatetime]  
           ,[title]  
           ,[postupdatetime]  
           ,[commentcount]  
           ,[viewcounts]  
           ,[siteid])      
SELECT  
   t1.postid,author,userid,postdatetime,title,postupdatetime,commentcount,viewcounts,@siteid  
   from blogapp..blog_posts t1  where t1.postid=@postid  
  
  IF @@ERROR <> 0  
  BEGIN  
   RETURN 0  
  END  
  ELSE  
  BEGIN  
   RETURN 1  
  END  
 END  
END  
  
  
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_posts_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
