USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_companystatus_Update]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商家状态修改 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-5 15:35:28
------------------------------------
CREATE PROCEDURE [dbo].[Manage_companystatus_Update]
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	
	DECLARE @companystatus int
	DECLARE @companycategoryid int 
	DECLARE @status int
	SELECT @companystatus=companystatus,@companycategoryid=companycategoryid,@status=status FROM company WHERE companyid=@companyid

	IF(@companystatus=1)
	BEGIN
		UPDATE company SET companystatus=0 WHERE companyid=@companyid
		IF(@status=1)
		BEGIN
			UPDATE companycategory SET companycount=companycount-1 WHERE companycategoryid=@companycategoryid
		END
	END
	ELSE
	BEGIN
		UPDATE company SET companystatus=1 WHERE companyid=@companyid
		IF(@status=1)
		BEGIN
			UPDATE companycategory SET companycount=companycount+1 WHERE companycategoryid=@companycategoryid	
		END
	END

IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN (1)
END
GO
