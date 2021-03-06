USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productcomment_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加一条商品评论记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-7-30 10:19:51
------------------------------------
CREATE PROCEDURE [dbo].[productcomment_ADD]
@productid int,
@author nvarchar(30),
@userid int,
@content ntext,
@parentid int,
@contact nvarchar(100),
@fromip nvarchar(30)

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	INSERT INTO [productcomment](
	[productid],[author],[userid],[content],[parentid],[commentdatetime],[contact],[fromip],[status]
	)VALUES(
	@productid,@author,@userid,@content,@parentid,GETDATE(),@contact,@fromip,1
	)

	UPDATE product SET commentcount=commentcount+1 WHERE productid=@productid

	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK TRANSACTION
		RETURN (-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN @@IDENTITY
	END

GO
