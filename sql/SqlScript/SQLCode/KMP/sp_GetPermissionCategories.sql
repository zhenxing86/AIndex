USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPermissionCategories]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[sp_GetPermissionCategories]
@ReturnValue int
AS
	SELECT * FROM T_PermissionCategories

GO
