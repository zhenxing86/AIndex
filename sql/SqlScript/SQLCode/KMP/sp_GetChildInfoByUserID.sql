USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetChildInfoByUserID]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetChildInfoByUserID]
@UserID int
AS
	SELECT dbo.T_Kindergarten.Name AS KindergartenName,dbo.T_Class.Name AS ClassName, dbo.T_Child.Name, 
	 dbo.T_Child.KindergartenID, 
      dbo.T_Child.ClassID, dbo.T_Child.UserID      
FROM dbo.T_Child INNER JOIN
      dbo.T_Class ON dbo.T_Child.ClassID = dbo.T_Class.ID INNER JOIN
      dbo.T_Kindergarten ON dbo.T_Class.KindergartenID = dbo.T_Kindergarten.ID 
WHERE dbo.T_Child.UserID = @UserID
GO
