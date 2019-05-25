USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreatePermission]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_CreatePermission]
@CategoryID int,
@Code varchar(200),
@Title varchar(50),
@kid int
AS
	INSERT INTO T_Permissions(CategoriesID,Code, Title, KindergartenID) VALUES(@CategoryID,@Code, @Title, @kid)
	RETURN @@IDENTITY
GO
