USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNoPermissionList]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[sp_GetNoPermissionList]
@RoleID int = NULL
AS
	Declare @KID int
	Select @KID=Kindergarten From T_Role Where ID=@RoleID

	IF @RoleID IS NULL
		SELECT ID, Code, Title, CategoriesID FROM T_Permissions ORDER BY Title
	ELSE
		SELECT ID, Code, Title, CategoriesID, KindergartenID
		FROM T_Permissions
		WHERE ID not in(select PermissionID from T_RolePermissions WHERE RoleID = @RoleID )
		AND (KindergartenID = @KID or KindergartenID = 0)
		ORDER BY Title
GO
