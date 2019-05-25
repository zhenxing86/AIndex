USE [BlogApp]
GO
/****** Object:  UserDefinedFunction [dbo].[IsFristBlogShowPost]    Script Date: 05/14/2013 14:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsFristBlogShowPost]
	(
	@postid int
	)
RETURNS INT
AS
	BEGIN
		DECLARE @isfrist int		
		DECLARE @count int
		SELECT @count=count(1) FROM  blog_startuser WHERE  postid =@postid
		IF(@count>0)
		BEGIN	
			SELECT @isfrist =1	 
		END
		ELSE
		BEGIN
		    SELECT @isfrist=0
		END		
		RETURN @isfrist
	END
GO
