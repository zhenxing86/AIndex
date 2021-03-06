USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproduct_Delete]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除专区显示商品 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 10:44:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproduct_Delete]
@commonproductid int
 AS 
	BEGIN TRANSACTION
	DECLARE @showtype INT
	DECLARE @currentorderno INT
	SELECT @showtype=showtype,@currentorderno=orderno FROM commonproduct WHERE commonproductid=@commonproductid and status=1
	UPDATE [commonproduct] SET orderno=orderno-1 WHERE showtype=@showtype and status=1 and orderno>@currentorderno
	UPDATE [commonproduct] SET status=-1 WHERE commonproductid=@commonproductid
--	DELETE [commonproduct] WHERE commonproductid=@commonproductid 

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
