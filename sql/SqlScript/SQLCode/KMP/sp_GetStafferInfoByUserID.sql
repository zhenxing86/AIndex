USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStafferInfoByUserID]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetStafferInfoByUserID]
@UserID int
AS
	SELECT dbo.T_Kindergarten.Name AS KindergartenName, 
      dbo.T_Kindergarten.ID AS KindergartenID, 
      dbo.T_Department.Name AS DepartmentName, 
      dbo.T_Department.ID AS DepartmentID, dbo.T_Staffer.Name AS StafferName, 
      dbo.T_Staffer.UserID
FROM dbo.T_Department INNER JOIN
      dbo.T_Kindergarten ON dbo.T_Department.ID = dbo.T_Kindergarten.ID INNER JOIN
      dbo.T_Staffer ON dbo.T_Department.ID = dbo.T_Staffer.DepartmentID
WHERE dbo.T_Staffer.UserID = @UserID
GO
