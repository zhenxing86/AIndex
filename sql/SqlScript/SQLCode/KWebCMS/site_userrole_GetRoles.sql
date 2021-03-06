USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_userrole_GetRoles]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-14
-- Description:	获取用户角色
-- =============================================
CREATE PROCEDURE [dbo].[site_userrole_GetRoles]
@userid int
AS
BEGIN
	SELECT a.[Name] FROM kmp..t_role a
	JOIN kmp..t_userroles b ON a.id=b.RoleID
	JOIN kmp..t_users c ON b.UserID=c.ID
	JOIN site_user d ON c.loginname=d.account
	WHERE d.userid=@userid
END



GO
