USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcategory_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加一条商品分类记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-10 11:20:29
------------------------------------
CREATE PROCEDURE [dbo].[productcategory_ADD]
@companyid int,
@title nvarchar(20),
@parentid int,
@orderno int,
@display int

 AS 
--	DECLARE @orderno INT
--	DECLARE @count INT
	DECLARE @productcategoryid INT

--	SELECT @count=COUNT(1) FROM productcategory WHERE companyid=@companyid and parentid=@parentid
--	SET @orderno=@count+1
	INSERT INTO [productcategory](
	[companyid],[title],[parentid],[orderno],[display],[createdate]
	)VALUES(
	@companyid,@title,@parentid,@orderno,@display,getdate()
	)
	SET @productcategoryid=@@IDENTITY


IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN 	@productcategoryid 
END

GO
