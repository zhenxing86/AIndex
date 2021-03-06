USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcomment_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：删除一条商品评论记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 10:19:51
------------------------------------
CREATE PROCEDURE [dbo].[productcomment_Delete]
@productcommentid int,
@companyid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @temp int
	DECLARE @productid int
	SELECT @temp=t1.companyid,@productid=t1.productid FROM product t1 inner join productcomment t2 on t1.productid=t2.productid

	IF(@companyid=@temp)
	BEGIN
--		DELETE [productcomment]
--		 WHERE productcommentid=@productcommentid 
		UPDATE productcomment SET status=-1 WHERE productcommentid=@productcommentid
		
		UPDATE product SET commentcount=commentcount-1 WHERE productid=@productid
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (-2)
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
