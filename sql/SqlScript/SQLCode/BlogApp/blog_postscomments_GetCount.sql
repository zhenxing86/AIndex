USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_postscomments_GetCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：日记评论总数
--项目名称：zgyeyblog
--说明：
--时间：2008-11-03 15:22:19
------------------------------------
CREATE PROCEDURE [dbo].[blog_postscomments_GetCount]
@postid int,
@userid int
 AS 
	DECLARE @TempID int
	DECLARE @postuserid int
	SELECT @postuserid=userid FROM blog_posts WHERE postid=@postid
	IF(@userid=@postuserid)
	BEGIN
		SELECT @TempID = count(1) FROM blog_postscomments  WHERE postsid=@postid
	END
	ELSE
	BEGIN
		SELECT @TempID = count(1) FROM blog_postscomments  WHERE postsid=@postid and (private=0 or (private=1 and fromuserid=@userid and @userid>0))
	END	
	RETURN @TempID	





GO
