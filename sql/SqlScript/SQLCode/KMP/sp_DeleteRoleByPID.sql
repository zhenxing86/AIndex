USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteRoleByPID]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_DeleteRoleByPID]
@PID int = 0
AS
	Delete T_RolePermissions where PermissionID = @PID
GO
