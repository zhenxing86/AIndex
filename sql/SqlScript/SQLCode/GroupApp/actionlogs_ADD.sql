USE [gyszq]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_ADD]    Script Date: 2014/11/24 23:09:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：增加操作日志 
--项目名称：ServicePlatform
--说明：
--时间：2010-2-25 9:56:53
------------------------------------
CREATE PROCEDURE [dbo].[actionlogs_ADD]
@actionid int,
@actionname nvarchar(50),
@actiondescription nvarchar(200),
@actionmodel nvarchar(20),
@objectid int,
@ownid int,
@ownname nvarchar(50)

 AS 

/*
	DECLARE @id int
	INSERT INTO [actionlogs](
	[actionid],[actionname],[actiondescription],[actionmodel],[actiondatetime],[objectid],[ownid],[ownname]
	)VALUES(
	@actionid,@actionname,@actiondescription,@actionmodel,getdate(),@objectid,@ownid,@ownname
	)
	SET @id = @@IDENTITY

IF(@@ERROR<>0)
BEGIN
	RETURN (-1)
END
ELSE
BEGIN
	RETURN (@id)
END

*/

GO
