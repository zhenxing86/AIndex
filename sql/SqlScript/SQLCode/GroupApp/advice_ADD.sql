USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[advice_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加建议 
--项目名称：ServicePlatformManage
--说明：
--时间：2010-2-24 9:20:09
------------------------------------
CREATE PROCEDURE [dbo].[advice_ADD]
@companyid int,
@content ntext

 AS 
	DECLARE @adviceid int
	INSERT INTO [advice](
	[companyid],[content],[createdatetime],[status]
	)VALUES(
	@companyid,@content,getdate(),1
	)
	SET @adviceid = @@IDENTITY

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (@adviceid)
END

GO
