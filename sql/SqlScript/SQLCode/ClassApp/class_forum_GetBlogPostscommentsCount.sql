USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_forum_GetBlogPostscommentsCount]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询博客日志级论坛留言回复数 
--项目名称：ClassHomePage
--说明：
--时间：2009-4-20 9:52:59
------------------------------------
create PROCEDURE [dbo].[class_forum_GetBlogPostscommentsCount]
@postid int,
@classid int,
@userid int
AS
	DECLARE @TempID int
	DECLARE @isclassteacher int
	DECLARE @kid int
	SELECT @kid=kid FROM basicdata.dbo.class WHERE cid=@classid	
	EXEC @isclassteacher=class_GetIsClassTeacher @userid,@classid
	IF(@isclassteacher=1 or (SELECT  count(1) FROM blogapp.dbo.permissionsetting WHERE kid=@kid and ptype=10)=0)
	BEGIN	
		SELECT @TempID = count(1) FROM blogapp.dbo.blog_postscomments WHERE postsid=@postid
		RETURN @TempID
	END
	ELSE
	BEGIN
		SELECT @TempID = count(1) FROM blogapp.dbo.blog_postscomments WHERE postsid=@postid AND (approve=1 or (fromuserid=@userid and @userid<>0))
		RETURN @TempID
	END




GO
