USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetInBoxByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：分页得到收件箱的短信 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-5 11:07:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetInBoxByPage]
@userid int,
@viewstatus int,
@page int,
@size int

 AS 
DECLARE @blogtype INT
DECLARE @createdatetime DATETIME
SELECT @blogtype=t3.usertype,@createdatetime=t1.createdatetime FROM blog_baseconfig t1 inner join BasicData.dbo.user_bloguser t2 on t1.userid=t2.bloguserid
 inner join BasicData.dbo.[user] t3 on t2.userid=t3.userid WHERE t1.userid=@userid


CREATE TABLE #messagebox
(
	id int identity(1,1),
	messageboxid int,
	touserid int,
	fromuserid int,
	msgtitle nvarchar(30),
	msgcontent ntext,
	sendtime datetime,
	viewstatus int,
	nickname nvarchar(40),
	iszgyey int
)

INSERT INTO #messagebox(messageboxid,touserid,fromuserid,msgtitle,msgcontent,sendtime,viewstatus,nickname,iszgyey)
SELECT messageboxid,touserid,fromuserid,msgtitle,msgcontent,sendtime,viewstatus,[dbo].UserNickName(fromuserid),0
FROM blog_messagebox WHERE touserid=@userid

IF(@blogtype=0)
BEGIN
	INSERT INTO #messagebox(messageboxid,touserid,fromuserid,msgtitle,msgcontent,sendtime,viewstatus,nickname,iszgyey)
	SELECT messageboxid,@userid,-1,msgtitle,msgcontent,sendtime,0,'中国幼儿园门户',1 FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=2) and messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxread WHERE userid=@userid)
			AND  messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)

	INSERT INTO #messagebox(messageboxid,touserid,fromuserid,msgtitle,msgcontent,sendtime,viewstatus,nickname,iszgyey)
	SELECT messageboxid,@userid,-1,msgtitle,msgcontent,sendtime,1,'中国幼儿园门户',1 FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=2) and messageboxid in (select messageboxid from blog_zgyey_messageboxread where userid=@userid)
	 AND  messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)
END
ELSE
BEGIN
	INSERT INTO #messagebox(messageboxid,touserid,fromuserid,msgtitle,msgcontent,sendtime,viewstatus,nickname,iszgyey)
	SELECT messageboxid,@userid,-1,msgtitle,msgcontent,sendtime,0,'中国幼儿园门户',1 FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=1) and messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxread WHERE userid=@userid)
			AND  messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)

	INSERT INTO #messagebox(messageboxid,touserid,fromuserid,msgtitle,msgcontent,sendtime,viewstatus,nickname,iszgyey)
	SELECT messageboxid,@userid,-1,msgtitle,msgcontent,sendtime,1,'中国幼儿园门户',1 FROM blog_zgyey_messagebox WHERE sendtime>@createdatetime and (sendtype=0 or sendtype=1) and messageboxid in (select messageboxid from blog_zgyey_messageboxread where userid=@userid) 
	AND  messageboxid not in(SELECT messageboxid FROM blog_zgyey_messageboxdelete WHERE userid=@userid)
END

DECLARE @messageboxcount int
DECLARE @prep int,@ignore int
DECLARE @tmptable TABLE
(
	row int IDENTITY(1,1),
	tmptableid bigint		
)

IF(@viewstatus!=-1)
BEGIN
	IF(@page>1)
	BEGIN

		SET @prep=@size*@page
		SET @ignore=@prep-@size
	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				id
			FROM 
				#messagebox 
			WHERE touserid=@userid AND viewstatus=@viewstatus
			order by
				sendtime desc

		SET ROWCOUNT @size
		SELECT --@messageboxcount AS messageboxcount ,
			 t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,t1.nickname,t1.iszgyey
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			#messagebox t1
		 ON 
			tmptable.tmptableid=t1.id 			 			 
		WHERE
			row>@ignore 
		
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT --@messageboxcount AS messageboxcount,
			t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,t1.nickname,t1.iszgyey
		FROM #messagebox t1 	
		WHERE t1.touserid=@userid AND t1.viewstatus=@viewstatus 
		order by sendtime desc		
	END
END
ELSE
BEGIN
	IF(@page>1)
	BEGIN
		SET @prep=@size*@page
		SET @ignore=@prep-@size
	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				id
			FROM 
				#messagebox 
			WHERE touserid=@userid
			order by
				sendtime desc

		SET ROWCOUNT @size
		SELECT --@messageboxcount AS messageboxcount ,
			 t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,t1.nickname,t1.iszgyey
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			#messagebox t1
		 ON 
			tmptable.tmptableid=t1.id 			 			 
		WHERE
			row>@ignore 
		
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT --@messageboxcount AS messageboxcount,
			t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,t1.nickname,t1.iszgyey
		FROM #messagebox t1 	
		WHERE t1.touserid=@userid
		order by sendtime desc		
	END
END
drop table #messagebox





GO
