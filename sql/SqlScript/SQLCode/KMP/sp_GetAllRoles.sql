USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllRoles]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE PROCEDURE [dbo].[sp_GetAllRoles]
@ReturnValue int
AS
	SELECT ID, Name, Kindergarten FROM T_Role ORDER BY Name ASC

GO
