USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStafferDetailsNoClassInfoByUserID]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_GetStafferDetailsNoClassInfoByUserID]
@UserID int
AS	

SELECT *
FROM dbo.T_Staffer 
WHERE (dbo.T_Staffer.UserID = @UserID)
GO
