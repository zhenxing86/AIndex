USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	修改管理员资料
-- =============================================
CREATE PROCEDURE [dbo].[site_user_Update]
@userid int,
@account nvarchar(60) ,
@password nvarchar(128) ,
@name nvarchar(60) ,
@usertype int
AS
BEGIN
--select * from site_user where account='admin'
--select * from basicdata.dbo.[user] where account='admin'
	declare @appuserid int
	select @appuserid=appuserid from site_user where [userid] = @userid

	UPDATE site_user
	SET [account] = @account,[password] = @password,[name] = @name,[usertype]=@usertype
	WHERE [userid] = @userid

	update basicdata.dbo.[user] set [account] = @account,[password] = @password,[usertype]=@usertype where userid=@appuserid

	IF @@ERROR <> 0 
	BEGIN	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_user_Update', @level2type=N'PARAMETER',@level2name=N'@password'
GO
