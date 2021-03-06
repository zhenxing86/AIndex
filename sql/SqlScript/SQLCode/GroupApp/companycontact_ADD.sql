USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[companycontact_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加一条商家联系方式记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-9-2 15:15:21
------------------------------------
CREATE PROCEDURE [dbo].[companycontact_ADD]
@companyid int,
@contacttype int,
@contactaccount nvarchar(30)
 AS 
	DECLARE @companycontactid int
	DECLARE @orderno int
	DECLARE @count int
	SELECT @count=count(1) FROM companycontact WHERE companyid=@companyid and contacttype=@contacttype
	SET @orderno=@count+1

	INSERT INTO [companycontact](
	[companyid],[contacttype],[contactaccount],[orderno],[status]
	)VALUES(
	@companyid,@contacttype,@contactaccount,@orderno,1
	)
	SET @companycontactid = @@IDENTITY

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN @companycontactid
	END



GO
