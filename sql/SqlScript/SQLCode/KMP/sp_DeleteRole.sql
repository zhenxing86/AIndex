USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteRole]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_DeleteRole]
@RoleID int
AS
	BEGIN TRANSACTION
		DELETE T_RolePermissions WHERE RoleID = @RoleID
		DELETE T_UserRoles WHERE RoleID = @RoleID
		DELETE T_Role WHERE ID = @RoleID
	COMMIT TRANSACTION
GO
