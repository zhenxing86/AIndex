USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Dictionary_Exists]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Dictionary_Exists]
@ID int
AS
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM T_Dictionary WHERE [ID] = @ID
	IF @TempID = 0
		RETURN 0
	ELSE
		RETURN 1
GO
