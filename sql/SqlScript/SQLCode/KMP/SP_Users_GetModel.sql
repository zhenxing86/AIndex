USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Users_GetModel]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_Users_GetModel]
@ID int
 AS 
	SELECT * FROM T_Users
	 WHERE [ID] = @ID
GO
