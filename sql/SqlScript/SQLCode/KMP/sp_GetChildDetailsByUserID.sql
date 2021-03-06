USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetChildDetailsByUserID]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetChildDetailsByUserID]
@UserID int
AS
	SELECT T_Child.Name,T_Child.ClassID,T_Child.VipStatus,T_Child.KindergartenID,dbo.T_Class.Theme,dbo.T_Child.videostatus,
dbo.T_Kindergarten.IsVipControl FROM dbo.T_Child 
Left OUTER join dbo.T_Class on dbo.T_Child.ClassID = dbo.T_Class.ID
INNER JOIN dbo.T_Kindergarten ON dbo.T_Class.KindergartenID = dbo.T_Kindergarten.ID
 WHERE UserID = @UserID
GO
