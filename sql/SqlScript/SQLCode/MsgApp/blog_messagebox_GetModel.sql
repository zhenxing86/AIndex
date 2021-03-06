USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetModel]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
---------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetModel]
@messageboxid int,
@userid int
 AS
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	BEGIN TRANSACTION



	DECLARE @fromuserid int
	DECLARE @tmpuserid int
	SELECT @tmpuserid=touserid,@fromuserid=fromuserid FROM blog_messagebox WHERE messageboxid=@messageboxid 

	IF(@tmpuserid<>@userid)
	BEGIN
		SELECT  t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,u.[name],u.headpicupdate,u.headpic
		FROM blog_messagebox t1 left JOIN BasicData..[user] u ON t1.touserid=u.userid
		WHERE  messageboxid=@messageboxid  and t1.deletetag=1		
	END
	ELSE IF(@fromuserid=-1)
	BEGIN
		SELECT 
			t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,'幼儿园门户','',''
		 FROM blog_messagebox t1
		 WHERE t1.messageboxid=@messageboxid 	
	END
	ELSE
	BEGIN
		SELECT  t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,u.[name],u.headpicupdate,u.headpic
		FROM blog_messagebox t1 left JOIN BasicData..[user] u ON t1.fromuserid=u.userid
		WHERE  messageboxid=@messageboxid  and t1.deletetag=1			
			
	END

	UPDATE blog_messagebox SET viewstatus=1 WHERE messageboxid=@messageboxid and touserid=@userid

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
