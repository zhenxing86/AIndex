USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[product_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：添加一条商品记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 9:00:40
------------------------------------
CREATE PROCEDURE [dbo].[product_ADD]
@companyid int,
@title nvarchar(50),
@description ntext,
@imgpath nvarchar(200),
@imgfilename nvarchar(50),
@targethref nvarchar(200),
@price nvarchar(30),
@productcategoryid int,
@productcategoryname nvarchar(30)

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION
	
	INSERT INTO [product](
	[companyid],[title],[description],[imgpath],[imgfilename],[targethref],[createdatetime],[commentcount],[imgcount],[price],[commonproductcategoryid],[viewcount],[productappraisecount],[productcategoryname],[status]
	)VALUES(
	@companyid,@title,@description,@imgpath,@imgfilename,@targethref,getdate(),0,0,@price,@productcategoryid,0,0,@productcategoryname,1
	)

	UPDATE company SET productscount=productscount+1 WHERE companyid=@companyid 

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (@@IDENTITY)
	END

GO
