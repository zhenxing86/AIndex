USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_AccountExists]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-14
-- Description:	验证用户帐号
-- =============================================
CREATE PROCEDURE [dbo].[site_user_AccountExists]
@account nvarchar(60)
AS
BEGIN
	IF EXISTS(SELECT account FROM site_user WHERE account=@account)
		return 1
	ELSE
	BEGIN
		IF EXISTS(SELECT loginname FROM kmp..t_users WHERE loginname=@account AND Activity=1)
		BEGIN
			RETURN 1
		END
		ELSE
		BEGIN
			RETURN 0
		END
	END
END
GO
