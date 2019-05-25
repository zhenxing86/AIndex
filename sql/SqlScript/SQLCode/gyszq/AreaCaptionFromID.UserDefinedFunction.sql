USE [gyszq]
GO
/****** Object:  UserDefinedFunction [dbo].[AreaCaptionFromID]    Script Date: 08/28/2013 14:42:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AreaCaptionFromID]
	(
	@id int
	)
RETURNS  varchar(40)
AS
	BEGIN
	DECLARE @Title varchar(40)
	SELECT @Title = Title  FROM [kmp]..[T_Area] WHERE id = @id		 
	RETURN @Title
	END
GO
