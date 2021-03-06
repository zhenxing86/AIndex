USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_UpdatePassowrd]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- =============================================
-- Author:		hanbin
-- Create date: 2009-06-09
-- Description:	修改密码
-- =============================================
CREATE PROCEDURE [dbo].[site_user_UpdatePassowrd]
@userid int,
@oldpassword nvarchar(64),
@newpassword nvarchar(64)
AS
BEGIN
	DECLARE @tempPassword nvarchar(64)
	SELECT @tempPassword=t1.[password] FROM BasicData..[user] t1  inner join  site_user t2 on t1.userid=t2.appuserid  WHERE t2.userid=@userid

	IF @tempPassword IS NULL
	BEGIN
		RETURN -1 --用户不存在
	END
	ELSE IF @tempPassword<>@oldpassword
	BEGIN
		RETURN -2 --旧密码错误
	END
	ELSE IF @tempPassword=@oldpassword
	BEGIN
		UPDATE site_user SET password=@newpassword WHERE userid=@userid
		UPDATE t1 set t1.[password]=@newpassword   from basicdata..[user] t1 inner join site_user t2  on  t1.userid=t2.appuserid where t2.userid=@userid
	END
	ELSE
	BEGIN
		RETURN -3 --其它错误
	END

	IF @@ERROR <> 0
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END

GO
