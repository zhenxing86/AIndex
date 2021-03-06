USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetInBoxCount]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：得到收件箱短信数 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-14 17:30:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetInBoxCount]
@userid int
 AS 
	DECLARE @blogtype INT
	DECLARE @createdatetime DATETIME
	SELECT @blogtype=t3.usertype,@createdatetime=t1.createdatetime FROM blog_baseconfig t1 inner join BasicData.dbo.user_bloguser t2 on t1.userid=t2.bloguserid
	 inner join BasicData.dbo.[user] t3 on t2.userid=t3.userid WHERE t1.userid=@userid
	DECLARE @messageboxcount int
	DECLARE @zgyeymessagecount int
	SELECT @messageboxcount=count(1) FROM blog_messagebox WHERE touserid=@userid
	IF(@blogtype=0)
	BEGIN
		SELECT @zgyeymessagecount=count(1) FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=2) and messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)
	END
	ELSE
	BEGIN
		SELECT @zgyeymessagecount=count(1) FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=1) and messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)
	END
	RETURN (@messageboxcount+@zgyeymessagecount)





GO
