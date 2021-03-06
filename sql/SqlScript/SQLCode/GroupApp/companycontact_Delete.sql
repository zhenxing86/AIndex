USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycontact_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：删除一条商家联系方式记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-2 15:15:21
------------------------------------
CREATE PROCEDURE [dbo].[companycontact_Delete]
@companycontactid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @orderno int
	SELECT @orderno=orderno FROM companycontact WHERE companycontactid=@companycontactid
	
	DELETE [companycontact]
	 WHERE companycontactid=@companycontactid 

	UPDATE companycontact SET orderno=orderno-1 WHERE orderno>@orderno

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
