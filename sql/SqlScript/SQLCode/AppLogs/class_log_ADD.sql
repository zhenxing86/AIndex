USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[class_log_ADD]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--用途：增加班级应用日志记录
--项目名称：
--说明：
--时间：2011-7-1 15:29:16
------------------------------------
CREATE PROCEDURE [dbo].[class_log_ADD]
@actionuserid int,
@actionusername nvarchar(20),
@actiontypeid int,
@actionobjectid int,
@actiondesc nvarchar(200),
@touserid int,
@tousername nvarchar(20),
@classid int

 AS 
	DECLARE @actionid int
	INSERT INTO [class_log](
	[actionuserid],[actionusername],[actiontypeid],[actionobjectid],[actiondesc],[actiondatetime],[touserid],[tousername],[classid]
	)VALUES(
	@actionuserid,@actionusername,@actiontypeid,@actionobjectid,@actiondesc,getdate(),@touserid,@tousername,@classid
	)
	SET @actionid = @@IDENTITY

IF(@@error<>0)
begin
	return (-1)
end
else
begin
	return @actionid
end


GO
