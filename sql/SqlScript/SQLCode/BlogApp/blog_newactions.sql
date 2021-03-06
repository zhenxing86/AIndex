USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_newactions]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：取最新动态
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-12-18 14:50:00
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_newactions]
 AS 
select top 10 t1.author +':发表了-'+t1.title as description, t1.userid, t1.postdatetime as actiontime
 from blog_posts t1 inner join blog_hotposts t3 on t1.postid = t3.postid
 inner join  BasicData.dbo.user_bloguser t4 on t1.userid=t4.bloguserid
 inner join  BasicData.dbo.[user] t5 on t4.userid=t5.userid
where  t1.title <>'我的博客开通啦'
 and t5.deletetag=1 and datediff(day,t5.regdatetime,getdate())>3
 order by t3.createdate desc




GO
