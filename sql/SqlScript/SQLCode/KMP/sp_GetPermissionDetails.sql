USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPermissionDetails]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_GetPermissionDetails]
@PermissionID int
AS
	SELECT * FROM T_Permissions WHERE ID = @PermissionID
GO
