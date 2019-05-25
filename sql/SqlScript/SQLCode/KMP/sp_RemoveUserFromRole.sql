USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_RemoveUserFromRole]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_RemoveUserFromRole]
@UserID int,
@RoleID int
AS
	DELETE T_UserRoles WHERE UserID = @UserID AND RoleID = @RoleID
GO
