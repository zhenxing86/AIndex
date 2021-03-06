USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Dictionary_Update]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Dictionary_Update]
@ID int,
@Caption varchar(200),
@Code varchar(50),
@Catalog int
 AS 
	UPDATE T_Dictionary SET 
	[Caption] = @Caption,[Code] = @Code,[Catalog] = @Catalog
	WHERE [ID] = @ID
GO
