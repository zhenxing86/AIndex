USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_companypassword_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商家密码重置 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-5 16:35:28
------------------------------------
CREATE PROCEDURE [dbo].[Manage_companypassword_Update]
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	UPDATE company SET [password] = '7C4A8D09CA3762AF61E59520943DC26494F8941B' WHERE companyid=@companyid
	

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
