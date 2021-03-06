USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：查询文档列表记录信息 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-10-03 21:30:07
--作者：along
--exec [thelp_documents_GetList] 8,0,0
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetList]
@categoryid int,
@page int,
@size int,
@level int
 AS

IF(@page>1)
BEGIN
	DECLARE @prep int,@ignore int
	
	SET @prep = @size * @page
	SET @ignore=@prep - @size

	DECLARE @documents TABLE
	(
		--定义临时表
		row int IDENTITY (1, 1),
		docid bigint
	)
	
	SET ROWCOUNT @prep
	IF(@Level=-1)
	BEGIN
		INSERT INTO @documents(docid)
		SELECT top 12
			docid
		FROM
			thelp_documents					
		ORDER BY
			createdatetime DESC
	END
	ELSE IF(@Level=0)
	BEGIN
	INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE
			deletetag=1 and categoryid in (SELECT categoryid FROM thelp_categories WHERE parentid=@categoryid) or categoryid=@categoryid
		ORDER BY
			createdatetime DESC
	END
	ELSE IF (@Level=1)
	BEGIN
		INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE
			deletetag=1 and categoryid=@categoryid
		ORDER BY
			createdatetime DESC
	END

		SET ROWCOUNT @size
		SELECT
			t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,t1.userid,t1.author,
			(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,
			(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
		FROM
			@documents as predocuments
		INNER JOIN
			thelp_documents t1
		ON
			predocuments.docid = t1.docid		
		WHERE
			row > @ignore
END
ELSE
BEGIN
	SET ROWCOUNT @size
	IF(@Level=-1)
	BEGIN		
		SELECT top 12
				t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
				(select count(*) from thelp_docattachs where docid=t1.docid) as attachscount,
				(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
			FROM
				thelp_documents t1
			where deletetag=1 and categoryid in (SELECT categoryid FROM thelp_categories WHERE parentid=@categoryid)
		order by createdatetime desc
	END

	ELSE IF(@Level=0)
	BEGIN		
		SELECT
				t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,
				(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
			FROM
				thelp_documents t1
			where deletetag=1 and categoryid in (SELECT categoryid FROM thelp_categories WHERE parentid=@categoryid) or categoryid=@categoryid
		order by createdatetime desc
	END
	ELSE IF (@Level=1)
	BEGIN
			SELECT
				t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,
				(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
			FROM
				thelp_documents t1
			where deletetag=1 and categoryid=@categoryid
		order by createdatetime desc
	END
END
--SET ROWCOUNT 0
--
--SELECT
--	count(*) AS "count"
--FROM
--	thelp_documents
--WHERE
--	categoryid=@categoryid
--
--SET NOCOUNT OFF






GO
