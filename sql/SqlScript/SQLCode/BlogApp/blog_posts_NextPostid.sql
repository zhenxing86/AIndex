USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_NextPostid]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







------------------------------------
--用途：下一篇日志
--项目名称：zgyeyblog
--说明：
--时间：2008-11-10 9:48:47
--[blog_posts_NextPostid] 70106,384874,1
--select max(postid) from blog_posts where userid=70106 and deletetag=1 and postid<384874
--select postid,title from blog_posts where userid=70106 and deletetag=1
------------------------------------
CREATE PROCEDURE [dbo].[blog_posts_NextPostid]
@userid int,
@postid int,
@isself int

AS

	declare @pid int
	IF(@isself=1)
	BEGIN
		select top 1 postid,title from blog_posts where userid=@userid and deletetag=1 and postid<@postid
		order by postid desc
	END
	ELSE
	BEGIN
		select top 1 postid,title from blog_posts where userid=@userid and deletetag=1 and poststatus=1 and postid<@postid		
		order by postid desc
	END

--	select 
--		t2.postid,t2.title
--	from blog_posts t2
--	where postid=@pid
--







GO
