USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_comments_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：取分页照片评论列表
--项目名称：zgyeyblog
--说明：
--时间：2008-11-03 11:49:31
------------------------------------
CREATE PROCEDURE [dbo].[album_comments_GetListByPage]
	@photoid int,
	@page int,
	@size int
 AS 
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
			photocommentid
		FROM 
			album_comments 
		WHERE photoid=@photoid
		order by
			commentdatetime desc

	SET ROWCOUNT @size
	SELECT 
		t1.photocommentid,t1.photoid,t1.userid,t1.author,t1.content,t1.commentdatetime,t1.parentid
	 FROM 
		@tmptable AS tmptable		
	 INNER JOIN
 		album_comments t1
	 ON 
		tmptable.tmptableid=t1.photocommentid 	
	WHERE
		row>@ignore 
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT		
		photocommentid,photoid,userid,author,content,commentdatetime,parentid
	FROM album_comments
	WHERE photoid=@photoid
	order by commentdatetime desc
END
	









GO
