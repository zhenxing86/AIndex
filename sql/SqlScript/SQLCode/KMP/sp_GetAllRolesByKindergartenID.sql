USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllRolesByKindergartenID]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_GetAllRolesByKindergartenID]
@KindergartenID int
AS
	SELECT ID, Name, Kindergarten FROM T_Role where Kindergarten=@KindergartenID ORDER BY Name ASC
GO
