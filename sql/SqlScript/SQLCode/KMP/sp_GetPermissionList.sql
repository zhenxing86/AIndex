USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPermissionList]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_GetPermissionList]
@RoleID int = NULL
AS
	IF @RoleID IS NULL
		SELECT ID, Code, Title, CategoriesID FROM T_Permissions ORDER BY Title
	ELSE
		SELECT ap.ID, ap.Title, ap.CategoriesID FROM T_Permissions ap INNER JOIN
		T_RolePermissions apr ON ap.ID = apr.PermissionID WHERE
		apr.RoleID = @RoleID ORDER BY ap.Title
GO
