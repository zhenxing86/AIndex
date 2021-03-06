USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messageboard_GetList]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





------------------------------------
--用途：取留言列表 
--项目名称：zgyeyblog
--说明：
--时间：2008-10-01 13:57:24 
--作者：along
------------------------------------
CREATE PROCEDURE [dbo].[blog_messageboard_GetList]
@userid int,
@page int,
@size int
 AS 

IF(@page>1)
BEGIN
	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @tmptable TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		tmptableid bigint
	)
	
	SET ROWCOUNT @prep
	INSERT INTO @tmptable(tmptableid)
		SELECT
			messageboardid
		FROM
			blog_messageboard
		WHERE
		userid=@userid AND parentid=0 
		ORDER BY
			msgdatetime DESC


		SET ROWCOUNT @size
		SELECT
			messageboardid,userid,fromuserid,author,content,msgstatus,msgdatetime,parentid
		FROM
			@tmptable as tmptable
		INNER JOIN
			blog_messageboard t1
		ON
			tmptable.tmptableid = t1.messageboardid
		WHERE
			row > @ignore
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
		messageboardid,userid,fromuserid,author,content,msgstatus,msgdatetime,parentid
	FROM
		blog_messageboard t1
	where userid=@userid AND parentid=0 
	order by msgdatetime desc
END






GO
