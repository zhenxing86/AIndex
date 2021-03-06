USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改一条商品记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_Update]
@productid int,
@title nvarchar(50),
@description ntext,
@imgpath nvarchar(200),
@imgfilename nvarchar(50),
@targethref nvarchar(200),
@price nvarchar(30),
@productcategoryid int,
@productcategoryname nvarchar(30)

 AS 
	IF(@imgpath<>'' and @imgfilename<>'')
	BEGIN
		UPDATE [product] SET 
		[title] = @title,[description] = @description,[imgpath] = @imgpath,[imgfilename] = @imgfilename,[targethref] = @targethref,[createdatetime] = getdate(),
		[price]=@price,[commonproductcategoryid]=@productcategoryid,[productcategoryname]=@productcategoryname
		WHERE productid=@productid 
	END
	ELSE
	BEGIN
		UPDATE [product] SET 
		[title] = @title,[description] = @description,[targethref] = @targethref,
		[price]=@price,[commonproductcategoryid]=@productcategoryid,[productcategoryname]=@productcategoryname
		WHERE productid=@productid 
	END
--[createdatetime] = getdate(),
	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END

GO
