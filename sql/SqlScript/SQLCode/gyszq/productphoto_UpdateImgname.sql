USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productphoto_UpdateImgname]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改一条商品图片名称 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 11:04:18
------------------------------------
CREATE PROCEDURE [dbo].[productphoto_UpdateImgname]
@productphotoid int,
@imgname nvarchar(100)
 AS 
	UPDATE [productphoto] SET 
	[imgname] = @imgname
	WHERE productphotoid=@productphotoid 

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END
GO
