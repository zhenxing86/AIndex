USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetModel]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到短信息的详细信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-5 11:07:33
------------------------------------
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
		SELECT 
			t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,[dbo].UserNickName(t1.touserid) as nickname
		 FROM blog_messagebox t1 --INNER JOIN blog_user t2 ON t1.touserid=t2.userid and t2.activity=1
		 WHERE t1.messageboxid=@messageboxid 		
	END
	ELSE IF(@fromuserid=-1)
	BEGIN
		SELECT 
			t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,'幼儿园门户'
		 FROM blog_messagebox t1
		 WHERE t1.messageboxid=@messageboxid 	
	END
	ELSE
	BEGIN	
		SELECT 
			t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,[dbo].UserNickName(t1.fromuserid) as nickname
		 FROM blog_messagebox t1 --INNER JOIN blog_user t2 ON t1.fromuserid=t2.userid and t2.activity=1
		 WHERE t1.messageboxid=@messageboxid 		
	END

	UPDATE blog_messagebox SET viewstatus=1 WHERE messageboxid=@messageboxid 

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
