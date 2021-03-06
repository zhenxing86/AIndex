USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[invest_user_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-04
-- Description:	会员注册
-- =============================================
CREATE PROCEDURE [dbo].[invest_user_Add]
@account nvarchar(20),
@password nvarchar(50),
@username nvarchar(30),
@nickname nvarchar(30),
@email nvarchar(50),
@gender nvarchar(10)
AS
BEGIN
	INSERT INTO invest_user(account,password,username,nickname,email,regdatetime,gender,status)
	VALUES(@account,@password,@username,@nickname,@email,GETDATE(),@gender,1)

	IF @@ERROR <> 0 
	BEGIN	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN @@IDENTITY
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'invest_user_Add', @level2type=N'PARAMETER',@level2name=N'@password'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'电子邮件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'invest_user_Add', @level2type=N'PARAMETER',@level2name=N'@email'
GO
