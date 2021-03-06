USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproduct_orderno_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改专区显示商品排序 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 10:44:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproduct_orderno_Update]
@commonproductid int,
@orderno int
AS 
	BEGIN TRANSACTION
	DECLARE @currentorderno INT
	DECLARE @showtype INT
	DECLARE @nextorderno INT
	DECLARE @nextcommonproductid INT
	SELECT @currentorderno=orderno,@showtype=showtype FROM commonproduct WHERE  commonproductid=@commonproductid and status=1

	DECLARE @maxorderno INT
	DECLARE @minorderno INT
	SELECT @maxorderno=max(orderno),@minorderno=min(orderno) FROM commonproduct WHERE showtype=@showtype AND status=1
	IF((@orderno=-1 and @currentorderno=@minorderno) or (@orderno=1 and @currentorderno=@maxorderno))
	BEGIN
		COMMIT TRANSACTION 
		RETURN (-2)
	END
	ELSE
	BEGIN
		SELECT @nextorderno=@currentorderno+@orderno
		SELECT @nextcommonproductid=commonproductid FROM commonproduct WHERE showtype=@showtype and orderno=@nextorderno and status=1
		UPDATE [commonproduct] SET [orderno] = @nextorderno	WHERE commonproductid=@commonproductid
		UPDATE [commonproduct] SET [orderno] = @currentorderno	WHERE commonproductid=@nextcommonproductid 
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
