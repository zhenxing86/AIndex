USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[accesslog_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加一条访问日志记录 
--项目名称：ServicePlatform
--说明：
--时间：2009-8-13 16:46:56
------------------------------------
CREATE PROCEDURE [dbo].[accesslog_ADD]
@companyid int,
@bloguserid int,
@fromip nvarchar(30),
@accesspage nvarchar(200),
@urlreferrer nvarchar(500),
@productid int

 AS 

/*
	DECLARE @accesslogid int
	INSERT INTO [accesslog](
	[companyid],[bloguserid],[fromip],[accesspage],[urlreferrer],[accessdatetime],[productid]
	)VALUES(
	@companyid,@bloguserid,@fromip,@accesspage,@urlreferrer,getdate(),@productid
	)
	SET @accesslogid = @@IDENTITY

	IF(@@ERROR<>0)
	BEGIN
		RETURN (-1)
	END
	ELSE
	BEGIN
		RETURN @accesslogid
	END
*/


GO
