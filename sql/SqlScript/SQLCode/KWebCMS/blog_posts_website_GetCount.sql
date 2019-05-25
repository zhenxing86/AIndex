USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_website_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------    
--用途：网站管理员设置精彩文章日志网站显示    
--项目名称：ZGYEYBLOG    
--说明：    
--时间：-01-18 16:30:07    
------------------------------------    
CREATE PROCEDURE [dbo].[blog_posts_website_GetCount]     
@kid int    
AS    
BEGIN    
 DECLARE @count int     
 SELECT @count=count(1)    
 FROM    
   blogapp..blog_posts t1 INNER JOIN  basicdata..user_bloguser t2 on t1.userid=t2.bloguserid    
     inner join basicdata..[user]  t3  ON t2.userid=t3.userid    
     WHERE t3.kid=@kid  and t1.deletetag=1  and t1.title<>'我的成长档案开通啦'  
     return @count    
END 
GO
