USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetSendBoxByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：分页得到发件箱的短信 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-5 11:07:33
------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetSendBoxByPage]
@userid int,
@page int,
@size int

 AS 
	DECLARE @messageboxcount int
	SELECT @messageboxcount=count(1) FROM blog_messagebox WHERE fromuserid=@userid 
	
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint		
		)
	
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
			SELECT 
				messageboxid
			FROM 
				blog_messagebox 
			WHERE fromuserid=@userid 
			order by
				sendtime desc

		SET ROWCOUNT @size
		SELECT 
			@messageboxcount AS messageboxcount,t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,[dbo].UserNickName(t1.touserid) as nickname
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			blog_messagebox t1
		 ON 
			tmptable.tmptableid=t1.messageboxid 
		 --INNER JOIN
			--blog_user t2
		 --ON t1.touserid=t2.userid and activity=1	
				 
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			@messageboxcount AS messageboxcount,t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,[dbo].UserNickName(t1.touserid) as nickname
		FROM blog_messagebox t1 --INNER JOIN blog_user t2 ON t1.touserid=t2.userid and activity=1
		WHERE fromuserid=@userid 
		order by sendtime desc		
	END





GO
