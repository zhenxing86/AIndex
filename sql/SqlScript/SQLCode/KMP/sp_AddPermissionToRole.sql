USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddPermissionToRole]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_AddPermissionToRole]
@RoleID int,
@PermissionID int
AS
	DECLARE @Count int

	SELECT @Count = Count(PermissionID) FROM T_RolePermissions WHERE
		RoleID = @RoleID and PermissionID = @PermissionID
	
	IF @Count = 0
		INSERT INTO T_RolePermissions(RoleID, PermissionID)
		VALUES(@RoleID, @PermissionID)
GO
