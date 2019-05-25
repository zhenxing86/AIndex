USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPermissionCategoryDetails]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_GetPermissionCategoryDetails]
@CategoryID int
AS
	SELECT ID, Title, Memo FROM T_PermissionCategories WHERE ID = @CategoryID
GO
