USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_GetUserIDByAccount1]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- ALTER date: 2011-08-07
-- Description:	根据用户帐号获取UserID
-- =============================================
CREATE PROCEDURE [dbo].[site_user_GetUserIDByAccount1]
@appuserid  int
AS
BEGIN
	DECLARE @userid int
	SELECT @userid=userid FROM site_user WHERE appuserid=@appuserid
	RETURN @userid
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'basicdata..[user]表的用户ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_user_GetUserIDByAccount1', @level2type=N'PARAMETER',@level2name=N'@appuserid'
GO
