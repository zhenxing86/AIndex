USE [BasicData]
GO
/****** Object:  UserDefinedFunction [dbo].[AreaCaptionFromID]    Script Date: 05/14/2013 14:36:18 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE FUNCTION [dbo].[AreaCaptionFromID]
	(
	@id int
	)
RETURNS  varchar(40)
AS
	BEGIN
	DECLARE @Title varchar(40)
	SELECT @Title = Title  FROM Area WHERE id = @id
		 
	RETURN @Title
	END
GO
