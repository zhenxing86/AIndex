USE [BlogApp]
GO
/****** Object:  UserDefinedFunction [dbo].[IsSplendidPosts]    Script Date: 05/14/2013 14:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsSplendidPosts]
	(
		@postid int
	)	
RETURNS INT
AS
	BEGIN	
		DECLARE @issplendidposts int
		IF(exists(select * from blog_splendidposts  where postid=@postid))
		BEGIN	
			SELECT @issplendidposts =1	 
		END
		ELSE
		BEGIN
		    SELECT @issplendidposts=0
		END		
		RETURN @issplendidposts
	END
GO
