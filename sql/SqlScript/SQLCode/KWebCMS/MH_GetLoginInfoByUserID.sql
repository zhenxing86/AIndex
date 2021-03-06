USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_GetLoginInfoByUserID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-31
-- Description:	获取登录后相关信息
-- =============================================
CREATE PROCEDURE [dbo].[MH_GetLoginInfoByUserID]
@userid int,
@account nvarchar(64)
AS
BEGIN
--	DECLARE @SiteName nvarchar(50)
--	DECLARE @NickName nvarchar(30)
--	DECLARE @UserType int
--	DECLARE @MailCount int
--
--	DECLARE @account nvarchar(30)
--	DECLARE @siteid int
--	SELECT @account=t2.account,@siteid=t1.siteid,@SiteName=t1.[name],@NickName=t2.[name]
--	FROM site t1,site_user t2 WHERE t1.siteid=t2.siteid AND t2.userid=@userid
--
--	SELECT @MailCount=count(*) FROM kmp..maillist WHERE readflag=0 AND recever=@siteid
--
--	SELECT @UserType=UserType
--	FROM kmp..T_Role t1,kmp..T_UserRoles t2,kmp..T_Users t3
--	WHERE t1.ID=t2.RoleID AND t2.UserID=t3.ID AND t1.Kindergarten=@siteid
--
--	SELECT 'SiteName'=@SiteName,'NickName'=@NickName,'UserType'=@UserType,'MailCount'=@MailCount
	DECLARE @BlogUserID int	
	SELECT @BlogUserID=userid FROM Blog..blog_user WHERE account=@account AND activity=1

	IF EXISTS(SELECT * FROM site_user WHERE userid=@userid AND account=@account)
	BEGIN
		SELECT 'SiteName'=t1.[name],'NickName'=t2.[name],'UserType'=usertype,
		'MailCount'=(SELECT count(*) FROM blog..blog_messagebox WHERE touserid=@BlogUserID AND viewstatus=0)
		FROM site t1,site_user t2 
		WHERE t1.siteid=t2.siteid AND t2.userid=@userid AND account=@account
	END
	ELSE
	BEGIN
		DECLARE @SiteName nvarchar(50)
		DECLARE @NickName nvarchar(30)
		DECLARE @UserType int
		DECLARE @MailCount int
		SELECT @UserType=UserType,@NickName=NickName FROM kmp..T_Users
		WHERE ID=@userid AND LoginName=@account
		IF @UserType>0
		BEGIN
			SELECT 'SiteName'=t1.[name],'NickName'=[NickName],'UserType'=UserType,
			'MailCount'=(SELECT count(*) FROM blog..blog_messagebox WHERE touserid=@BlogUserID AND viewstatus=0)
			FROM kmp..T_Kindergarten t1,kmp..T_Users t2,kmp..T_staffer t3
			WHERE t1.ID=t3.KindergartenID AND t3.UserID=t2.ID AND t2.ID=@userid AND LoginName=@account			
		END
		ELSE
		BEGIN
			SELECT 'SiteName'=t1.[name],'NickName'=[NickName],'UserType'=UserType,
			'MailCount'=(SELECT count(*) FROM blog..blog_messagebox WHERE touserid=@BlogUserID AND viewstatus=0)
			FROM kmp..T_Kindergarten t1,kmp..T_Users t2,kmp..T_child t3
			WHERE t1.ID=t3.KindergartenID AND t3.UserID=t2.ID AND t2.ID=@userid AND LoginName=@account
		END
--		SELECT 'SiteName'=t1.[name],'NickName'=[NickName],'UserType'=UserType,
--		'MailCount'=(SELECT count(*) FROM kmp..maillist WHERE readflag=0 AND recever=t1.ID)
--		FROM kmp..T_Kindergarten t1,kmp..T_Users t2,kmp..T_staffer t3,kmp..T_child t4
--		WHERE (t1.ID=t3.KindergartenID AND t3.UserID=t2.ID AND t2.ID=100 AND LoginName='13811111121' AND UserType>0) OR 
--			  (t1.ID=t4.KindergartenID AND t4.UserID=t2.ID AND t2.ID=100 AND LoginName='13811111121' AND UserType=0)
	END
END






GO
