USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_zgyey_messagebox_GetModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：得到门户发送短信息的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2010-05-15 11:07:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_zgyey_messagebox_GetModel]
@messageboxid int,
@userid int
 AS 
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION
	DECLARE @tmpuserid int
	IF EXISTS(SELECT * FROM blog_zgyey_messageboxread WHERE messageboxid=@messageboxid and userid=@userid)
	BEGIN
		SELECT 
			t1.messageboxid,@userid as touserid,-1 as fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,1 as viewstatus,'幼儿园门户' as nickname
		 FROM blog_zgyey_messagebox t1
		 WHERE t1.messageboxid=@messageboxid 	
	END
	ELSE
	BEGIN 	
		INSERT INTO blog_zgyey_messageboxread(messageboxid,userid,readtime) values(@messageboxid,@userid,getdate())
		SELECT 
			t1.messageboxid,@userid as touserid,-1 as fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,0 as viewstatus,'幼儿园门户' as nickname
		 FROM blog_zgyey_messagebox t1
		 WHERE t1.messageboxid=@messageboxid 
	END

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
		RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN (1)
	END





GO
