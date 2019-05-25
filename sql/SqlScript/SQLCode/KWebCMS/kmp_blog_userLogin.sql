USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_blog_userLogin]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kmp_blog_userLogin]
@account nvarchar(20),
@password nvarchar(40)
AS
BEGIN
	DECLARE @userid int
	EXEC @userid=Blogapp..[blog_user_UserLogin] @account,@password
	RETURN @userid
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_blog_userLogin', @level2type=N'PARAMETER',@level2name=N'@password'
GO
