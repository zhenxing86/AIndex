USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_CreateRole]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









CREATE PROCEDURE [dbo].[sp_CreateRole]
@Name varchar(50),
@Kindergarten int

AS
	INSERT INTO T_Role(Name, Kindergarten) VALUES(@Name, @Kindergarten)
	RETURN @@IDENTITY
GO
