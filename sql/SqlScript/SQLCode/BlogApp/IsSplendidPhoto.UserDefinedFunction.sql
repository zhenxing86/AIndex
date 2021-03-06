USE [BlogApp]
GO
/****** Object:  UserDefinedFunction [dbo].[IsSplendidPhoto]    Script Date: 05/14/2013 14:36:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsSplendidPhoto]
	(
		@photoid int,
		@categoriesid int
	)
RETURNS INT
AS
	BEGIN	
		DECLARE @issplendidphoto int
		IF(exists(select * from blog_splendidphotos  where photoid=@photoid and categoriesid=@categoriesid))
		BEGIN	
			SELECT @issplendidphoto =1	 
		END
		ELSE
		BEGIN
		    SELECT @issplendidphoto=0
		END		
		RETURN @issplendidphoto
	END
GO
