USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRoleListByPID]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_GetRoleListByPID]
@PID int = 0
AS
	select RoleID from T_RolePermissions where PermissionID = @PID
GO
