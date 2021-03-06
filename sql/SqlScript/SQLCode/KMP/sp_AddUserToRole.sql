USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddUserToRole]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_AddUserToRole]
@UserID int,
@RoleID int
AS
	DECLARE @Count int
	
	SELECT @Count = Count(UserID) FROM T_UserRoles WHERE
		RoleID = @RoleID AND UserID = @UserID
	IF @Count = 0
		INSERT INTO T_UserRoles(UserID, RoleID)
		VALUES(@UserID, @RoleID)
GO
