USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePermission]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_UpdatePermission]
@PermissionID int,
@Title varchar(50),
@Code varchar(50)
AS
	UPDATE T_Permissions SET Title = @Title, Code=@Code WHERE ID = @PermissionID
GO
