USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePermission]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[sp_DeletePermission]
@PermissionID int
AS
	BEGIN TRANSACTION
		DELETE T_Permissions WHERE ID = @PermissionID
		DELETE T_RolePermissions WHERE PermissionID = @PermissionID
	COMMIT TRANSACTION
GO
