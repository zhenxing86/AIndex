USE [KWebCMS]
GO
/****** Object:  UserDefinedFunction [dbo].[IsSysCategoryRelationPosts]    Script Date: 05/14/2013 14:43:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsSysCategoryRelationPosts]
	(
		@postid int
	)	
RETURNS INT
AS
	BEGIN	
		DECLARE @issyscategoryposts int
		IF(exists(select * from blog_postsyscategory_relation  where postid=@postid))
		BEGIN	
			SELECT @issyscategoryposts =1	 
		END
		ELSE
		BEGIN
		    SELECT @issyscategoryposts=0
		END		
		RETURN @issyscategoryposts
	END
GO
