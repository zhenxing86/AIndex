USE [KWebCMS]
GO
/****** Object:  UserDefinedFunction [dbo].[IsSyncKindergarten]    Script Date: 05/14/2013 14:43:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  FUNCTION [dbo].[IsSyncKindergarten]
	(
	@siteid int
   
	)
RETURNS  INT
AS
	BEGIN
	DECLARE @issync varchar(40)
	IF((select city from site where siteid=@siteid)=240)
	BEGIN
		SELECT @issync=1	 
	END
	ELSE
	BEGIN
		SELECT @issync=0		
	END
	RETURN @issync
	END
GO
