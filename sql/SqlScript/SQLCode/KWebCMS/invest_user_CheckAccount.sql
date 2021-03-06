USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[invest_user_CheckAccount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-04
-- Description:	验证帐号是否存在
-- =============================================
CREATE PROCEDURE [dbo].[invest_user_CheckAccount]
@account nvarchar(20)
AS
BEGIN
	IF EXISTS(SELECT userid FROM invest_user WHERE account=@account)
	BEGIN
		RETURN 1
	END
	ELSE
	BEGIN
		RETURN 0
	END
END



GO
