USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[invest_user_UpdatePassword]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-04
-- Description:	重置会员密码
-- =============================================
CREATE PROCEDURE [dbo].[invest_user_UpdatePassword]
@userid int,
@password nvarchar(50)
AS
BEGIN
	UPDATE invest_user SET password=@password WHERE userid=@userid
	IF @@ERROR <> 0
	BEGIN
		return -1
	END
	ELSE
	BEGIN
		RETURN 1
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'invest_user_UpdatePassword', @level2type=N'PARAMETER',@level2name=N'@password'
GO
