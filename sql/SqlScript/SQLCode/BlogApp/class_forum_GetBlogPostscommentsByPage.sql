USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetBlogPostscommentsByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：查询博客日志级论坛留言回复 
--项目名称：ClassHomePage
--说明：
--时间：2009-4-20 9:52:59
------------------------------------
create PROCEDURE [dbo].[class_forum_GetBlogPostscommentsByPage]
@postid int,
@page int,
@size int,
@classid int,
@userid int
AS

return 1




GO
