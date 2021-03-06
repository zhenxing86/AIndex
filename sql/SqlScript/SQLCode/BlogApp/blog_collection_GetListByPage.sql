USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[blog_collection_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-----------------------------------
--用途：取收藏日志列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-3 16:53:01
------------------------------------
--exec [blog_collection_GetListByPage] 17, 2, 5
--select * From blog_collection
CREATE PROCEDURE [dbo].[blog_collection_GetListByPage]
	@userid int,
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
			collectionid
		FROM 
			blog_collection
		WHERE userid=@userid 
		order by
			createdatetime desc

	SET ROWCOUNT @size
	SELECT 
		t1.postid,t1.userid,t1.author,t1.postdatetime,t1.title,t1.[content],t2.collectionid,t2.userid as selfuserid,t2.createdatetime
	 FROM 
		@tmptable AS tmptable		
	 INNER JOIN
 		blog_collection t2
	 ON 
		tmptable.tmptableid=t2.collectionid 
	 LEFT JOIN
		blog_posts t1 
     ON t1.postid=t2.postid
	WHERE
		row>@ignore 
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT		
		t1.postid,t1.userid,t1.author,t1.postdatetime,t1.title,t1.[content],t2.collectionid,t2.userid as selfuesrid,t2.createdatetime
	FROM 
		blog_posts t1
	INNER JOIN
		blog_collection t2
	ON
		t1.postid=t2.postid
	WHERE t2.userid=@userid
	order by createdatetime desc
END





GO
