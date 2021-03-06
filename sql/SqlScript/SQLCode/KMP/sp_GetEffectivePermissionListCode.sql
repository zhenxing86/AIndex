USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEffectivePermissionListCode]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_GetEffectivePermissionListCode]
@UserID int
AS
   SELECT DISTINCT T_Permissions.Code FROM T_RolePermissions
	 inner join T_Permissions on 
	T_RolePermissions.PermissionID=T_Permissions.ID WHERE RoleID IN
	(SELECT RoleID FROM T_UserRoles WHERE UserID = @UserID)
GO
