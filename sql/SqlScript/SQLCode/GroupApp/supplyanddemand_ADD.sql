USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[supplyanddemand_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加一条供求记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-26 15:00:28
------------------------------------
CREATE PROCEDURE [dbo].[supplyanddemand_ADD]
@companyid int,
@bloguserid int,
@content nvarchar(500),
@title nvarchar(100)
 AS 
	DECLARE @supplyanddemandid INT
	DECLARE @orderno int
	DECLARE @count int
	SELECT @count=count(1) FROM [supplyanddemand] 
	SET @orderno=@count+1

	INSERT INTO [supplyanddemand](
	[companyid],[bloguserid],[content],[createdatetime],[orderno],[title],[status]
	)VALUES(
	@companyid,@bloguserid,@content,getdate(),@orderno,@title,1
	)
	SET @supplyanddemandid = @@IDENTITY

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN (@supplyanddemandid)
	END

GO
