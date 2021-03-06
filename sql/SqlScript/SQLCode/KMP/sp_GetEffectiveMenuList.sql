USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEffectiveMenuList]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetEffectiveMenuList]
@UserID int,
@ParentID int
AS
SELECT * FROM T_Tree WHERE PermissionID in (SELECT DISTINCT T_Permissions.ID FROM T_RolePermissions
	 inner join T_Permissions on 
	T_RolePermissions.PermissionID=T_Permissions.ID WHERE RoleID IN
	(SELECT RoleID FROM T_UserRoles WHERE UserID = @UserID)) AND ParentID = @ParentID
order by T_Tree.OrderID


GO
