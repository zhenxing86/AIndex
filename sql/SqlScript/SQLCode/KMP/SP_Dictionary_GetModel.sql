USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Dictionary_GetModel]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Dictionary_GetModel]
@ID int
 AS 
	SELECT * FROM T_Dictionary
	 WHERE [ID] = @ID
GO
