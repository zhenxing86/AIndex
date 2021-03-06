USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproductcategory_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：删除专区商品分类 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-19 16:50:42
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproductcategory_Delete]
@commonproductcategoryid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	IF EXISTS(SELECT * FROM commonproductcategory WHERE parentid=@commonproductcategoryid)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -2
	END
	ELSE
	BEGIN
		DECLARE @orderno int
		DECLARE @parentid int
		SELECT @orderno=orderno,@parentid=parentid FROM [commonproductcategory] WHERE commonproductcategoryid=@commonproductcategoryid
		DELETE [commonproductcategory] 	WHERE commonproductcategoryid=@commonproductcategoryid 	
		UPDATE [commonproductcategory] SET orderno=orderno-1 WHERE orderno>@orderno and parentid=@parentid
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
