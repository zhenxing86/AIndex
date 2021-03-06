USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproductcategory_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加专区商品分类 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-19 16:50:42
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproductcategory_ADD]
@title nvarchar(100),
@parentid int,
@display int,
@orderno int

 AS 
	DECLARE @commonproductcategoryid INT
--	DECLARE @orderno int
--	SELECT @orderno=MAX(orderno) FROM commonproductcategory WHERE parentid=@parentid
--	IF(@orderno is null)
--	BEGIN
--		SET @orderno=0
--	END	

	INSERT INTO [commonproductcategory](
	[title],[parentid],[display],[orderno]
	)VALUES(
	@title,@parentid,@display,@orderno
	)
	SET @commonproductcategoryid = @@IDENTITY

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (@commonproductcategoryid)
	END




GO
