USE [gyszq]
GO
/****** Object:  UserDefinedFunction [dbo].[GetCompanyCategoryTitle]    Script Date: 08/28/2013 14:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetCompanyCategoryTitle]
	(
		@companycategoryid int
	)	
RETURNS NVARCHAR(50)
AS
	BEGIN	
		DECLARE @title int
		IF(exists(select * from companycategory  where companycategoryid=@companycategoryid and source=1))
		BEGIN	
			SELECT @title=title from companycategory  where companycategoryid=@companycategoryid and source=1
		END
		ELSE
		BEGIN
		    SELECT @title='其他'
		END		
		RETURN @title
	END
GO
