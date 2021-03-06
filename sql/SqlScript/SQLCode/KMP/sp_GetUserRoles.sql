USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserRoles]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_GetUserRoles]
@UserID int
AS
	SELECT ur.RoleID, r.Name FROM T_UserRoles ur
		INNER JOIN T_Role r ON ur.RoleID = r.ID  WHERE ur.UserID = @UserID
GO
