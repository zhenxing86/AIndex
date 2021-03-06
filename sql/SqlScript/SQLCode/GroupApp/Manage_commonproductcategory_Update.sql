USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_commonproductcategory_Update]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：修改专区商品分类 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-1-19 16:50:42
------------------------------------
CREATE PROCEDURE [dbo].[Manage_commonproductcategory_Update]
@commonproductcategoryid int,
@title nvarchar(100),
@display int,
@orderno int
 AS 
	UPDATE [commonproductcategory] SET 
	[title] = @title,[display] = @display,[orderno]=@orderno
	WHERE commonproductcategoryid=@commonproductcategoryid 

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (1)
	END



GO
