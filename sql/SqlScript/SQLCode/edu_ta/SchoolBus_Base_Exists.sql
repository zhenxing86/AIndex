USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[SchoolBus_Base_Exists]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[SchoolBus_Base_Exists]
@ID int
AS
	DECLARE @TempID int
	SELECT @TempID = count(1) FROM [SchoolBus_Base] WHERE ID=@ID 
	IF @TempID = 0
		RETURN 0
	ELSE
		RETURN 1








GO
