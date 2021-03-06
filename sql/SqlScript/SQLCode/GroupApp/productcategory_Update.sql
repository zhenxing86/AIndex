USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcategory_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改一条商品分类记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-10 16:58:19
------------------------------------
CREATE PROCEDURE [dbo].[productcategory_Update]
@productcategoryid int,
@title nvarchar(20),
--@parentid int,
@orderno int,
@display int
 AS 
--	DECLARE @oldcount int
--	DECLARE @oldparentid int
--	SELECT @oldparentid=parentid FROM productcategory WHERE productcategoryid=@productcategoryid
--	SELECT @oldcount=count(1) FROM productcategory WHERE parentid=@productcategoryid
--	IF(@oldparentid=0 and @oldcount>0)
--	BEGIN
--		RETURN (-2)
--	END
--	ELSE
--	BEGIN
--		IF(@parentid<>@oldparentid)
--		BEGIN
--			DECLARE @orderno int
--			DECLARE @count int
--			SELECT @orderno=orderno FROM productcategory WHERE productcategoryid=@productcategoryid
--			SELECT @count=count(1) FROM productcategory where parentid=@parentid
--			UPDATE productcategory SET orderno=orderno-1 WHERE parentid=@oldparentid and orderno>@orderno
--			UPDATE [productcategory] SET [title] = @title,parentid=@parentid,orderno=@count+1	WHERE productcategoryid=@productcategoryid 
--		END
--		ELSE
--		BEGIN
--			UPDATE [productcategory] SET [title] = @title  WHERE productcategoryid=@productcategoryid
--		END	
--	END
	UPDATE [productcategory] SET [title] = @title,[orderno]=@orderno,[display]=@display WHERE productcategoryid=@productcategoryid

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (1)
END


GO
