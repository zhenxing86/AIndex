USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_user_Exists]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途:判断用户是否存在
--说明：
------------------------------------
CREATE PROCEDURE [dbo].[Manage_user_Exists]   
@account nvarchar(200)
AS

	DECLARE @TempID int
	SELECT @TempID = count(1) from BasicData.dbo.[user] where account=@account and deletetag=1
	RETURN @TempID








GO
