USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePermissionCategory]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[sp_DeletePermissionCategory]
@CategoryID int
AS
	BEGIN TRANSACTION
		DELETE T_Permissions WHERE CategoriesID = @CategoryID
		DELETE T_PermissionCategories WHERE ID = @CategoryID
	COMMIT TRANSACTION
GO
