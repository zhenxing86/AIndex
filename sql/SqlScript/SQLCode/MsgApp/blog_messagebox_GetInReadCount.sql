USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetInReadCount]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-------------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetInReadCount]
@userid int
 AS

DECLARE @blogtype INT
	DECLARE @createdatetime DATETIME
	SELECT @blogtype=t3.usertype,@createdatetime=t1.createdatetime FROM  blogapp..blog_baseconfig t1 inner join BasicData.dbo.user_bloguser t2 on t1.userid=t2.bloguserid
	 inner join BasicData.dbo.[user] t3 on t2.userid=t3.userid WHERE t2.userid=@userid
	DECLARE @messageboxcount int
	DECLARE @zgyeymessagecount int
	SELECT @messageboxcount=count(1) FROM blog_messagebox WHERE touserid=@userid AND viewstatus=1 and deletetagmy=1
	IF(@blogtype=0)
	BEGIN
		SELECT @zgyeymessagecount=count(1) FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=2) and messageboxid in (select messageboxid from blog_zgyey_messageboxread where userid=@userid) AND  messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)
	END
	ELSE
	BEGIN
		SELECT @zgyeymessagecount=count(1) FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=1) and messageboxid in (select messageboxid from blog_zgyey_messageboxread where userid=@userid) AND  messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)
	END
	RETURN (@messageboxcount+@zgyeymessagecount)




GO
