USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_categories_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：分页取相册列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
--exec [blog_posts_GetListByPage] 4,0,0
------------------------------------
CREATE PROCEDURE [dbo].[album_categories_GetListByPage]
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
			categoriesid
		FROM
			album_categories
		WHERE
			userid=@userid and deletetag=1
		ORDER BY
			orderno DESC


		SET ROWCOUNT @size
		SELECT
			categoriesid,userid,title,description,displayorder,albumdispstatus,photocount,createdatetime,
			coverphoto as defaultcoverphoto,
			coverphoto,
			coverphotodatetime AS coverphotoupdatetime,
			orderno,viewpermission,t1.net
		FROM
			@tmptable as tmptable
		INNER JOIN
			album_categories t1
		ON
			tmptable.tmptableid = t1.categoriesid
		WHERE
			row > @ignore  ORDER BY	orderno DESC
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
		categoriesid,userid,title,description,displayorder,albumdispstatus,photocount,createdatetime,
		coverphoto as defaultcoverphoto,
		coverphoto,
		coverphotodatetime AS coverphotoupdatetime,
		orderno,viewpermission,t1.net
	FROM
		album_categories t1
	where userid=@userid and deletetag=1
	order by orderno desc
END





GO
