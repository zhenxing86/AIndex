USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Child_GetModel]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Child_GetModel]
@ID int
 AS 

	SELECT dbo.T_Child.*, dbo.T_Users.*
	FROM dbo.T_Child LEFT OUTER JOIN
	      dbo.T_Users ON dbo.T_Child.UserID = dbo.T_Users.ID
		 WHERE T_Users.[ID] = @ID
GO
