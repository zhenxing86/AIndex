USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_PreviousPostid]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-13
-- Description:	下一篇日志
-- Memo:		
*/
CREATE PROCEDURE [dbo].[blog_posts_PreviousPostid]
	@userid int,
	@postid int,
	@isself int
AS
BEGIN
	SET NOCOUNT ON	
	
	IF(@isself = 1)
	BEGIN
		select top 1 postid, title 
			from blog_posts 
			where userid = @userid 
				and deletetag = 1 
				and postid > @postid
			order by postid
	END
	ELSE
	BEGIN
		select top 1 postid, title 
			from blog_posts 
			where userid = @userid 
				and deletetag = 1 
				and poststatus = 1 
				and postid > @postid		
			order by postid
	END
END

GO
