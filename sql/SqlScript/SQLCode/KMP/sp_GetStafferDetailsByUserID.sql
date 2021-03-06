USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetStafferDetailsByUserID]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetStafferDetailsByUserID]
@UserID int
AS	
declare @ClassID int
--declare @UserID int
--set @UserID = 1211
select @ClassID = classid from t_stafferclass where UserID = @UserID
if (@ClassID is not null)
begin
SELECT dbo.T_Staffer.*, dbo.T_StafferClass.ClassID AS ClassID, dbo.T_Class.*
FROM dbo.T_Staffer LEFT OUTER JOIN
      dbo.T_StafferClass ON dbo.T_Staffer.UserID = dbo.T_StafferClass.UserID
	left outer join dbo.T_Class on dbo.T_stafferClass.ClassID = dbo.T_Class.ID
WHERE (dbo.T_Staffer.UserID = @UserID)
end
else
begin
SELECT *,'t3' as theme, '' as classid
FROM dbo.T_Staffer 
WHERE (dbo.T_Staffer.UserID = @UserID)
end

--exec sp_GetUserDetails 1211

GO
