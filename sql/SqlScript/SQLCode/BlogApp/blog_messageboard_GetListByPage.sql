USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_messageboard_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：分页取留言列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
--exec [blog_messageboard_GetListByPage] 4,0,0
------------------------------------
CREATE PROCEDURE [dbo].[blog_messageboard_GetListByPage]
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
		userid=@userid AND parentid=0 OR messageboardid in(select t1.messageboardid from dbo.blog_messageboard t1 where fromuserid=@userid and (select count(1) from blog_messageboard t2 where t2.parentid=t1.messageboardid)>0 )
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
	where userid=@userid AND parentid=0 OR messageboardid in(select t1.messageboardid from dbo.blog_messageboard t1 where fromuserid=@userid and (select count(1) from blog_messageboard t2 where t2.parentid=t1.messageboardid)>0 )
	order by msgdatetime desc
END





GO
