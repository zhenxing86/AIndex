USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[Manage_productcomment_status_Delete]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：商品评价删除
--项目名称：ServicePlatformManage
--说明：
--时间：2010-01-15 11:48:04
------------------------------------
CREATE PROCEDURE [dbo].[Manage_productcomment_status_Delete]
@productcommentid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED	
	BEGIN TRANSACTION

	UPDATE t1 SET commentcount=commentcount-1 FROM product t1 INNER JOIN productcomment t2 ON t1.productid=t2.productid WHERE t2.productcommentid=@productcommentid
	UPDATE productcomment SET status=-1 WHERE productcommentid=@productcommentid

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
