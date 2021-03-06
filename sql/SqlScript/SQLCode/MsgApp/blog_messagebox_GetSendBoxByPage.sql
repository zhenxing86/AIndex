USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messagebox_GetSendBoxByPage]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
----------------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[blog_messagebox_GetSendBoxByPage]
@userid int,
@page int,
@size int

 AS
DECLARE @messageboxcount int
	SELECT @messageboxcount=count(1) FROM blog_messagebox WHERE fromuserid=@userid and deletetag=1
	
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
			WHERE fromuserid=@userid and deletetag=1 
			order by
				sendtime desc

		SET ROWCOUNT @size
		SELECT 
			@messageboxcount AS messageboxcount,t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,u.[name],u.headpicupdate,u.headpic,[dbo].[GetBlogIdByUserId](touserid),[dbo].[GetBlogIdByUserId](fromuserid)
		 FROM 
			@tmptable AS tmptable		
		 INNER JOIN
 			blog_messagebox t1
		 ON 
			tmptable.tmptableid=t1.messageboxid 
		 left JOIN
			BasicData..[user] u ON t1.touserid=u.userid 
				 
		WHERE
			row>@ignore 			
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
			@messageboxcount AS messageboxcount,t1.messageboxid,t1.touserid,t1.fromuserid,t1.msgtitle,t1.msgcontent,t1.sendtime,t1.viewstatus,u.[name],u.headpicupdate,u.headpic,[dbo].[GetBlogIdByUserId](touserid),[dbo].[GetBlogIdByUserId](fromuserid)
		FROM blog_messagebox t1 left JOIN BasicData..[user] u ON t1.touserid=u.userid
		WHERE fromuserid=@userid and t1.deletetag=1
		order by sendtime desc		
	END

GO
