USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[invest_user_GetUserIDByAccount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-12
-- Description:	根据用户帐号获取UserID
-- =============================================
CREATE PROCEDURE [dbo].[invest_user_GetUserIDByAccount]
@account nvarchar(20)
AS
BEGIN
	DECLARE @userid int
	SELECT @userid=userid FROM invest_user WHERE account=@account
	RETURN @userid
END


GO
