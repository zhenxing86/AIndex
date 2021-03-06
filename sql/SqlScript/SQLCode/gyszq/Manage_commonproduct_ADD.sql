USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproduct_ADD]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加专区显示商品	 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-02-01 10:44:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproduct_ADD]
@productid int,
@showtype int
 AS 
	BEGIN TRANSACTION
	DECLARE @commonproductid INT
	IF(NOT EXISTS (SELECT * FROM commonproduct WHERE productid=@productid and showtype=@showtype and status=1))	
	BEGIN
		INSERT INTO [commonproduct](
		[productid],[showtype],[orderno],[createdatetime],[status]
		)VALUES(
		@productid,@showtype,1,getdate(),1
		)
		SET @commonproductid = @@IDENTITY
		UPDATE [commonproduct] SET orderno=orderno+1 WHERE showtype=@showtype and status=1

	END
	ELSE
	BEGIN
		DECLARE @currentorderno INT
		SELECT @commonproductid=commonproductid,@currentorderno=orderno FROM commonproduct WHERE productid=@productid and showtype=@showtype and status=1
		UPDATE [commonproduct] SET orderno=orderno-1 WHERE showtype=@showtype and status=1 and orderno>@currentorderno
		UPDATE [commonproduct] SET status=-1 WHERE commonproductid=@commonproductid
	END

IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN (@commonproductid)
END
GO
