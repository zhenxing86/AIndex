USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[invest_user_CheckLogin]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-05
-- Description:	验证会员登录
-- =============================================
CREATE PROCEDURE [dbo].[invest_user_CheckLogin]
@account nvarchar(20),
@password nvarchar(50)
AS
BEGIN
	DECLARE @userid int
	DECLARE @status int
	SELECT @userid=userid,@status=status FROM invest_user WHERE account=@account AND password=@password
	IF @userid IS NULL
	BEGIN
		RETURN -1
	END
	ELSE 
	BEGIN
		IF @status > 0
		BEGIN
			RETURN @userid
		END
		ELSE
		BEGIN
			RETURN 0
		END
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'invest_user_CheckLogin', @level2type=N'PARAMETER',@level2name=N'@password'
GO
