USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_periodicalproduct_ADD]    Script Date: 08/28/2013 14:42:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加期刊商品 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-4-20 16:58:54
------------------------------------
CREATE PROCEDURE [dbo].[Manage_periodicalproduct_ADD]
@periodicalid int,
@productid int
 AS 
	BEGIN TRANSACTION
IF(@periodicalid=0)
BEGIN
	insert into ExeSP..periodicalproduct_info(periodicalid,productid,createdatetime,actiondatetime,iscfq) SELECT periodicalid,productid,createdatetime,getdate(),0 FROM periodicalproduct WHERE productid=@productid
	DELETE periodicalproduct WHERE productid=@productid	
END
ELSE
BEGIN
	DECLARE @count INT
	DECLARE @periodicalproductid INT
	DECLARE @commonproductcategoryid INT
	DECLARE @parentid int
	SELECT @commonproductcategoryid=t2.commonproductcategoryid,@parentid=t2.parentid FROM product t1 INNER JOIN commonproductcategory t2 ON t1.commonproductcategoryid=t2.commonproductcategoryid WHERE t1.productid=@productid
	WHILE(@parentid<>0)
	BEGIN
		SELECT @commonproductcategoryid=commonproductcategoryid,@parentid=parentid from commonproductcategory where commonproductcategoryid=@parentid
	END
	
	SELECT @count=count(1) FROM periodicalproduct t1 inner join product t2 on t1.productid=t2.productid	WHERE t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid))
	IF(@count<16)
	BEGIN
		IF EXISTS(SELECT * FROM periodicalproduct WHERE productid=@productid)
		BEGIN
			DECLARE @oldperiodicalid int
			DECLARE @oldorderno int
			SELECT @periodicalproductid=periodicalproductid,@oldperiodicalid=periodicalid,@oldorderno=orderno FROM periodicalproduct WHERE productid=@productid
			IF(@periodicalid<>@oldperiodicalid)
			BEGIN
				UPDATE t1 SET orderno=orderno-1
				FROM [periodicalproduct] t1 INNER JOIN product t2 ON t1.productid=t2.productid
				WHERE t1.periodicalid=@oldperiodicalid and t1.orderno>@oldorderno and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid))

				UPDATE t1 SET orderno=orderno+1
				FROM [periodicalproduct] t1 INNER JOIN product t2 ON t1.productid=t2.productid
				WHERE  t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid))
				
				UPDATE periodicalproduct SET periodicalid=@periodicalid,orderno=1 WHERE productid=@productid
			END
		END
		ELSE
		BEGIN
			UPDATE t1 SET orderno=orderno+1
			FROM [periodicalproduct] t1 INNER JOIN product t2 ON t1.productid=t2.productid
			WHERE  t1.periodicalid=@periodicalid and t1.status=1 and (t2.commonproductcategoryid=@commonproductcategoryid or t2.commonproductcategoryid in(select commonproductcategoryid from commonproductcategory where parentid=@commonproductcategoryid))

			INSERT INTO [periodicalproduct](
			[periodicalid],[productid],[orderno],[createdatetime],[status]
			)VALUES(
			@periodicalid,@productid,1,getdate(),1
			)
			SET @periodicalproductid = @@IDENTITY
		END
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (-2)
	END
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
