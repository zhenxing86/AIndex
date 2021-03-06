USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_Staffer_GetModel]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[sp_Staffer_GetModel]
@ID int
 AS 

	SELECT dbo.T_Staffer.*, dbo.T_Users.*
	FROM dbo.T_Staffer LEFT OUTER JOIN
	      dbo.T_Users ON dbo.T_Staffer.UserID = dbo.T_Users.ID
		 WHERE T_Users.[ID] = @ID
GO
