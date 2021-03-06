USE [BlogApp]
GO
/****** Object:  UserDefinedFunction [dbo].[UserCommentMessageboardCount]    Script Date: 05/14/2013 14:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[UserCommentMessageboardCount]
(
	@userid int
)
RETURNS INT
AS
	BEGIN
		DECLARE @count INT,@messageboardcount INT, @albumcommentcount INT, @postcommentcount INT
		SELECT @messageboardcount=COUNT(1) FROM blog_messageboard WHERE userid=@userid
		SELECT @albumcommentcount=COUNT(1) FROM album_comments WHERE userid=@userid
		SELECT @postcommentcount=COUNT(1) FROM blog_postscomments WHERE fromuserid=@userid
		SELECT @count=@messageboardcount+@albumcommentcount+@postcommentcount		
		RETURN @count
	END
GO
