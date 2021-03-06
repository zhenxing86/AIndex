USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproductcategory_UpdateOrderno]    Script Date: 08/28/2013 14:42:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改专区商品分类排序 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-19 16:50:42
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproductcategory_UpdateOrderno]
@commonproductcategoryid int,
@orderno int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @curorderno int
	DECLARE @curparentid int
	DECLARE @nextorderno int
	DECLARE @nextcategoryid int

	SELECT @curorderno=orderno,@curparentid=parentid FROM [commonproductcategory] WHERE	commonproductcategoryid=@commonproductcategoryid 
	SELECT @nextorderno=@curorderno+@orderno
	SELECT @nextcategoryid=commonproductcategoryid FROM [commonproductcategory] WHERE parentid=@curparentid AND orderno=@nextorderno
	UPDATE [commonproductcategory] SET 	[orderno] = @nextorderno WHERE commonproductcategoryid=@commonproductcategoryid 
	UPDATE [commonproductcategory] SET 	[orderno] = @curorderno WHERE commonproductcategoryid=@nextcategoryid 

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
