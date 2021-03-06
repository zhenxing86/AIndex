USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_periodicalproduct_orderno_Update]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改期刊商品排序 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-4-20 16:58:54
------------------------------------
CREATE PROCEDURE [dbo].[Manage_periodicalproduct_orderno_Update]
@periodicalproductid int,
@orderno int
AS 
	BEGIN TRANSACTION
	DECLARE @currentorderno INT
	DECLARE @commonproductcategoryid INT
	DECLARE @nextorderno INT
	DECLARE @nextperiodicalproductid INT
	DECLARE @parentid INT
	DECLARE @productid INT
	DECLARE @periodicalid INT
	SELECT @productid=productid,@periodicalid=periodicalid,@currentorderno=orderno FROM periodicalproduct WHERE periodicalproductid=@periodicalproductid

	SELECT @commonproductcategoryid=t2.commonproductcategoryid,@parentid=t2.parentid FROM product t1 INNER JOIN commonproductcategory t2 ON t1.commonproductcategoryid=t2.commonproductcategoryid WHERE t1.productid=@productid
	WHILE(@parentid<>0)
	BEGIN
		SELECT @commonproductcategoryid=commonproductcategoryid,@parentid=parentid from commonproductcategory where commonproductcategoryid=@parentid
	END

	DECLARE @maxorderno INT
	DECLARE @minorderno INT
	SELECT @maxorderno=max(t1.orderno),@minorderno=min(t1.orderno)
	FROM [periodicalproduct] t1 INNER JOIN product t2 ON t1.productid=t2.productid
	WHERE t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid))

	IF((@orderno=-1 and @currentorderno=@minorderno) or (@orderno=1 and @currentorderno=@maxorderno))
	BEGIN
		COMMIT TRANSACTION 
		RETURN (-2)
	END
	ELSE
	BEGIN
		SELECT @nextorderno=@currentorderno+@orderno
		SELECT @nextperiodicalproductid=periodicalproductid 
		FROM [periodicalproduct] t1 INNER JOIN product t2 ON t1.productid=t2.productid
		WHERE t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid)) and orderno=@nextorderno

		UPDATE [periodicalproduct] SET [orderno] = @nextorderno	WHERE periodicalproductid=@periodicalproductid
		UPDATE [periodicalproduct] SET [orderno] = @currentorderno	WHERE periodicalproductid=@nextperiodicalproductid 
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
