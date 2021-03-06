USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcategory_Delete]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：删除一条商品分类记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-10 16:58:19
------------------------------------
CREATE PROCEDURE [dbo].[productcategory_Delete]
@productcategoryid int
 AS 
IF EXISTS(SELECT * FROM productcategory WHERE parentid=@productcategoryid)
BEGIN
	RETURN (-2)
END
ELSE
BEGIN
		DECLARE @orderno int
		DECLARE @parentid int
		SELECT @orderno=orderno,@parentid=parentid FROM [productcategory] WHERE productcategoryid=@productcategoryid
		DELETE [productcategory] WHERE productcategoryid=@productcategoryid	
		UPDATE [productcategory] SET orderno=orderno-1 WHERE orderno>@orderno and parentid=@parentid 
END

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN 	(1) 
END
GO
