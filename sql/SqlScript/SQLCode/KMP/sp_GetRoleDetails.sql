USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRoleDetails]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_GetRoleDetails]
@RoleID int
AS
	SELECT ID, Name, Kindergarten FROM T_Role WHERE ID = @RoleID
GO
