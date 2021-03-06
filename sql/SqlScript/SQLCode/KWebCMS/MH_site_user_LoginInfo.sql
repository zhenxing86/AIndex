USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_user_LoginInfo]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-25
-- Description:	获取用户登录必备信息
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_user_LoginInfo]
@account nvarchar(50)
AS
BEGIN
	DECLARE @BlogUserID int
	DECLARE @BlogNickName nvarchar(50)
	DECLARE @BlogUserType int

	DECLARE @KmpUserID int
	DECLARE @KmpNickName nvarchar(50)
	DECLARE @KmpUserType int

	DECLARE @KWebCMSUserID int
	DECLARE @KWebCMSNickName nvarchar(50)
	DECLARE @KWebCMSUserType int

	SELECT @BlogUserID=userid,@BlogNickName=nickname FROM Blog..blog_user WHERE account=@account AND activity=1
	SELECT @BlogUserType=blogtype FROM blog..blog_baseconfig where userid=@BlogUserID
	SELECT @KmpUserID=ID,@KmpNickName=NickName,@KmpUserType=usertype FROM KMP..T_Users WHERE LoginName=@account AND Activity=1
	SELECT @KWebCMSUserID=userid,@KWebCMSNickName=name,@KWebCMSUserType=usertype FROM site_user WHERE account=@account

	SELECT 
		'BlogUserID'=@BlogUserID,'BlogNickName'=@BlogNickName,'BlogUserType'=@BlogUserType,
		'KmpUserID'=@KmpUserID,'KmpNickName'=@KmpNickName,'KmpUserType'=@KmpUserType,
		'KWebCMSUserID'=@KWebCMSUserID,'KwebCMSNickName'=@KwebCMSNickName,'KwebCMSUserType'=@KwebCMSUserType
END









GO
