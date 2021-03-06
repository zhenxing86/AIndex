USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[productappraise_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加一条产品评价记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-13 9:40:48
------------------------------------
CREATE PROCEDURE [dbo].[productappraise_ADD]
@productid int,
@level int,
@author nvarchar(30),
@userid int,
@parentid int,
@contact nvarchar(100),
@memo nvarchar(200),
@fromip nvarchar(30)

 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION

	DECLARE @productappraiseid int
	INSERT INTO [productappraise](
	[productid],[level],[author],[userid],[parentid],[contact],[memo],[appraisedatetime],[fromip],[status]
	)VALUES(
	@productid,@level,@author,@userid,@parentid,@contact,@memo,getdate(),@fromip,1
	)
	SET @productappraiseid = @@IDENTITY
	UPDATE product SET productappraisecount=productappraisecount+1 WHERE productid=@productid 

IF(@@ERROR<>0)
BEGIN
	ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	COMMIT TRANSACTION
	RETURN @productappraiseid
END

GO
