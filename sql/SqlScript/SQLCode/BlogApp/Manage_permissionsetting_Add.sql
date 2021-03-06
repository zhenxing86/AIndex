USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_permissionsetting_Add]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加配置权限
--项目名称：zgyeyblog
--说明：
--时间：2009-12-11 18:00:19
------------------------------------
create  PROCEDURE [dbo].[Manage_permissionsetting_Add]
@ptype int,
@kid int
 AS 
	IF NOT EXISTS(SELECT * FROM permissionsetting WHERE ptype=@ptype AND kid=@kid)
	BEGIN
		INSERT INTO permissionsetting(ptype,kid) values(@ptype,@kid)
	END
	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END



GO
