USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commoncompany_orderno_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改品牌商家排序 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-1 16:29:55
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commoncompany_orderno_Update]
@commoncompanyid int,
@orderno int
 AS 

	BEGIN TRANSACTION
	DECLARE @currentorderno INT
	DECLARE @commonproductcategoryid INT
	DECLARE @nextorderno INT
	DECLARE @nextcommoncompanyid INT
	SELECT @currentorderno=orderno,@commonproductcategoryid=commonproductcategoryid FROM [commoncompany] WHERE commoncompanyid=@commoncompanyid and status=1

	DECLARE @maxorderno INT
	DECLARE @minorderno INT
	SELECT @maxorderno=max(orderno),@minorderno=min(orderno) FROM [commoncompany] WHERE commonproductcategoryid=@commonproductcategoryid AND status=1
	IF((@orderno=-1 and @currentorderno=@minorderno) or (@orderno=1 and @currentorderno=@maxorderno))
	BEGIN
		COMMIT TRANSACTION 
		RETURN (-2)
	END
	ELSE
	BEGIN
		SELECT @nextorderno=@currentorderno+@orderno
		SELECT @nextcommoncompanyid=commoncompanyid FROM [commoncompany] WHERE commonproductcategoryid=@commonproductcategoryid and orderno=@nextorderno and status=1
		UPDATE [commoncompany] SET [orderno] = @nextorderno	WHERE commoncompanyid=@commoncompanyid
		UPDATE [commoncompany] SET [orderno] = @currentorderno	WHERE commoncompanyid=@nextcommoncompanyid 
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
