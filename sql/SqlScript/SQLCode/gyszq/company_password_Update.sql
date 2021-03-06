USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_password_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改帐户密码 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-11 9:09:49
------------------------------------
CREATE PROCEDURE [dbo].[company_password_Update]
@companyid int,
@oldpwd nvarchar(100),
@newpwd nvarchar(100)

 AS 
	
	
	DECLARE @pwd nvarchar(100)
	
	SELECT @pwd=password
    FROM company 
	WHERE companyid=@companyid 

	IF (@pwd<>@oldpwd)
	BEGIN
		RETURN(-1)
	END
	ELSE
	BEGIN
		UPDATE company SET 
		[password] = @newpwd
		WHERE companyid=@companyid 

		RETURN(1)
	END
GO
