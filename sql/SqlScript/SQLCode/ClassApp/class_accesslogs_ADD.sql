USE [ClassApp]
GO
/****** Object:  StoredProcedure [dbo].[class_accesslogs_ADD]    Script Date: 2014/11/24 22:57:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












------------------------------------
--用途：增加班级主页访问日志 
--项目名称：classhomepage
--说明：
--时间：2008-02-06 10:06:41
------------------------------------
CREATE PROCEDURE [dbo].[class_accesslogs_ADD]
@classid int,
@fromuserid int
 AS 	


	DECLARE @tmp int
	DECLARE @lastaccessdatetime datetime

	if(@fromuserid >0)
	begin
		SELECT top 1 @tmp = classid,@lastaccessdatetime=accessdatetime FROM AppAccessLogs.dbo.class_accesslogs
		WHERE classid=@classid and fromeuserid=@fromuserid

		DECLARE @accessnum int
		SELECT @accessnum=accessnum FROM class_config where cid=@classid
		IF NOT EXISTS(SELECT 1 FROM class_config WHERE cid=@classid)
		BEGIN
			INSERT INTO class_config(cid,accessnum) values(@classid,1)
		END
		ELSE IF(@accessnum is null)
		BEGIN
			UPDATE class_config SET accessnum=1 WHERE cid=@classid	
		END
		ELSE
		BEGIN
			UPDATE class_config SET accessnum=accessnum+1 WHERE cid=@classid	
		END	

		IF (@tmp>0)
		BEGIN
			IF(DATEDIFF(S,@lastaccessdatetime,getdate()) > 30)
			BEGIN
				UPDATE AppAccessLogs.dbo.class_accesslogs SET accessdatetime=getdate()
				WHERE classid=@classid and fromeuserid=@fromuserid
			END
		END
		ELSE
		BEGIN
			INSERT INTO AppAccessLogs.dbo.class_accesslogs(
			[classid],[fromeuserid],[accessdatetime]
			)VALUES(
			@classid,@fromuserid,getdate()
			)
		END
	end


	
	IF @@ERROR <> 0 
	BEGIN 
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END

















GO
