USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetListByKinDocCategoryid]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




------------------------------------
--用途：查询共享幼儿园文档列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2009-6-30 21:00:07
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetListByKinDocCategoryid]
@categoryid int,
@page int,
@size int
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
		INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE			
			deletetag=1 and (kindoccategoryid=@categoryid or kindoccategoryid in (select kincategoryid from kin_doc_category where parentid=@categoryid)) and kindisplay=1 
		ORDER BY
			createdatetime DESC


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
			SELECT
				t1.docid,categoryid,title,description,body,classdisplay,kindisplay,publishdisplay,createdatetime,viewcount,userid,author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,
				(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
			FROM
				thelp_documents t1
			where deletetag=1 and (t1.kindoccategoryid=@categoryid or t1.kindoccategoryid in (select kincategoryid from kin_doc_category where parentid=@categoryid)) and t1.kindisplay=1 
		order by t1.createdatetime desc

END







GO
