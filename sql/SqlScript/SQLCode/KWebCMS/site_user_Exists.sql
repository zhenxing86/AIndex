USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_user_Exists]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE PROCEDURE [dbo].[site_user_Exists]
@account nvarchar(50),
@password nvarchar(64)
AS
BEGIN
    declare @returnvalue int
    exec  @returnvalue=basicdata..ValidateUserExists @account,@password
   return @returnvalue
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_user_Exists', @level2type=N'PARAMETER',@level2name=N'@password'
GO
