USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserDetailsByUserName]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_GetUserDetailsByUserName]
@UserName varchar(50)
AS
	SELECT * FROM T_Users WHERE LoginName = @UserName and activity = 1
GO
