USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SMSTemp_GetCount]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SMSTemp_GetCount]
@tmptype int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM SMS_Temp WHERE smstype=@tmptype
	RETURN @count
END




GO
