USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_ClearPermissionsFromRole]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_ClearPermissionsFromRole]
@RoleID int
AS
	DELETE T_RolePermissions WHERE RoleID = @RoleID
GO
