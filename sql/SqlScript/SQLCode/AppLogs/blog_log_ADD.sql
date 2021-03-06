USE [AppLogs]
GO
/****** Object:  StoredProcedure [dbo].[blog_log_ADD]    Script Date: 2014/11/24 21:14:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：增加博客应用日志记录
--项目名称：
--说明：
--时间：2011-7-1 15:29:16
------------------------------------
CREATE PROCEDURE [dbo].[blog_log_ADD]
@actionuserid int,
@actionusername nvarchar(20) = '',
@actiontypeid int,
@actionobjectid int,
@actiondesc nvarchar(200),
@touserid int,
@tousername nvarchar(20)

 AS 
	DECLARE @actionid int
	INSERT INTO [blog_log](
	[actionuserid],[actionusername],[actiontypeid],[actionobjectid],[actiondesc],[actiondatetime],[touserid],[tousername]
	)VALUES(
	@actionuserid,@actionusername,@actiontypeid,@actionobjectid,@actiondesc,getdate(),@touserid,@tousername
	)
	IF EXISTS(SELECT 1 FROM blog_new_actionlogs WHERE actionuserid=@actionuserid)
	BEGIN
		UPDATE blog_new_actionlogs SET actionusername=@actionusername,actiondesc=@actiondesc,actiontypeid=@actiontypeid,
				actiondatetime=getdate(),actionobjectid=@actionobjectid,touserid=@touserid,tousername=@tousername
		WHERE actionuserid=@actionuserid
	END
	ELSE
	BEGIN
		INSERT INTO blog_new_actionlogs(actionuserid,actionusername,actiondesc,actiontypeid,actiondatetime,actionobjectid,touserid,tousername)
		VALUES(@actionuserid,@actionusername,@actiondesc,@actiontypeid,getdate(),@actionobjectid,@touserid,@tousername)
	END
	
	
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
