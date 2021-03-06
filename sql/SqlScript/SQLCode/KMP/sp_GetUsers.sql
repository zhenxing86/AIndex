USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUsers]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_GetUsers]
@key varchar(50),
@kid varchar(50),
@UserType varchar(10)
AS

if(@UserType=0)
begin
if(len(@kid) >0 and @kid > 0)
begin
SELECT dbo.T_Users.LoginName, dbo.T_Users.ID, dboT_.Users.Style, dbo.T_Users.UserType, 
      dbo.T_Users.Activity, dbo.T_Staffer.Name, dbo.T_Staffer.Mobile, 
      dbo.T_Staffer.KindergartenID
FROM dbo.T_Users RIGHT OUTER JOIN
      dbo.T_Staffer ON dbo.T_Users.ID = dbo.T_Staffer.UserID where dbo.T_Staffer.kindergartenID = @kid and dbo.T_Users.LoginName like '%' +@key + '%'	
      and dbo.T_Users.activity = 1
end
else
begin
SELECT dbo.T_Users.LoginName, dbo.T_Users.ID, dbo.T_Users.Style, dbo.T_Users.UserType, 
      dboT_.Users.Activity, dbo.T_Staffer.Name, dbo.T_Staffer.Mobile, 
      dbo.T_Staffer.KindergartenID
FROM dbo.T_Users RIGHT OUTER JOIN
      dbo.T_Staffer ON dbo.T_Users.ID = dbo.T_Staffer.UserID where dbo.T_Users.LoginName like '%' +@key + '%'
      and dbo.T_Users.activity = 1
end
end
else
begin
	if(len(@kid) >0 and @kid > 0)
begin
SELECT dbo.T_Users.LoginName, dbo.T_Users.ID, dboT_.Users.Style, dbo.T_Users.UserType, 
      dbo.T_Users.Activity, dbo.T_Child.Name, dbo.T_Child.Mobile, 
      dbo.T_Child.KindergartenID
FROM dbo.T_Users RIGHT OUTER JOIN
      dbo.T_Child ON dbo.T_Users.ID = dbo.T_Child.UserID where dbo.T_Child.kindergartenID = @kid and dbo.T_Users.LoginName like '%' +@key + '%'	
      and dbo.T_Users.activity = 1
end
else
begin
SELECT dbo.T_Users.LoginName, dbo.T_Users.ID, dbo.T_Users.Style, dbo.T_Users.UserType, 
      dboT_.Users.Activity, dbo.T_Child.Name, dbo.T_Child.Mobile, 
      dbo.T_Child.KindergartenID
FROM dbo.T_Users RIGHT OUTER JOIN
      dbo.T_Child ON dbo.T_Users.ID = dbo.T_Child.UserID where dbo.T_Users.LoginName like '%' +@key + '%'
      and dbo.T_Users.activity = 1
end
end

GO
