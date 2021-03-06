USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[album_photos_GetListByPage]    Script Date: 2014/11/25 11:50:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：分页取相片列表 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
--exec [album_photos_GetListByPage] 4,0,0
------------------------------------
CREATE PROCEDURE [dbo].[album_photos_GetListByPage]
@categoriesid int,
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
			photoid
		FROM
			album_photos
		WHERE
			categoriesid=@categoriesid and deletetag=1
		ORDER BY
			orderno DESC


		SET ROWCOUNT @size
		SELECT
			photoid,categoriesid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,isflashshow,orderno,net
		FROM
			@tmptable as tmptable
		INNER JOIN
			album_photos t1
		ON
			tmptable.tmptableid = t1.photoid
		WHERE
			row > @ignore
			ORDER BY  orderno DESC
END
ELSE
BEGIN
	SET ROWCOUNT @size
	SELECT
		photoid,categoriesid,title,filename,filepath,filesize,viewcount,commentcount,uploaddatetime,iscover,isflashshow,orderno,net
	FROM
		album_photos t1
	where categoriesid=@categoriesid and deletetag=1
	order by orderno desc
END






GO
