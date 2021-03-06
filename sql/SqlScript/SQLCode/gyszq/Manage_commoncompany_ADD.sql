USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commoncompany_ADD]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加品牌商家 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 16:29:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commoncompany_ADD]
@companyid int,
@commonproductcategoryid int
 AS 
	BEGIN TRANSACTION	
	DECLARE @commoncompanyid INT
	IF(NOT EXISTS(SELECT * FROM commoncompany WHERE companyid=@companyid and commonproductcategoryid=@commonproductcategoryid and status=1))
	BEGIN
		UPDATE [commoncompany] SET orderno=orderno+1 WHERE commonproductcategoryid=@commonproductcategoryid and status=1
		INSERT INTO [commoncompany](
		[companyid],[commonproductcategoryid],[orderno],[createdatetime],[status]
		)VALUES(
		@companyid,@commonproductcategoryid,1,getdate(),1
		)
		SET @commoncompanyid = @@IDENTITY
	END
	ELSE
	BEGIN		
		SELECT @commoncompanyid=commonproductcategoryid FROM commoncompany WHERE companyid=@companyid and commonproductcategoryid=@commonproductcategoryid and status=1
	END

IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN (@commoncompanyid)
END
GO
