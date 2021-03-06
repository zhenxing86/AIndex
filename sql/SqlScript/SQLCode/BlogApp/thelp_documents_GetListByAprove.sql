USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetListByAprove]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--用途：按审核状态查询公共文档 
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-21 10:38:17
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetListByAprove]
@aprove int,
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
			deletetag=1 and aprove=@aprove AND publishdisplay=1 AND (pubcategoryid=@categoryid or pubcategoryid in (select pubcategoryid from pub_doc_category where parentid=@categoryid))
		ORDER BY
			createdatetime DESC


		SET ROWCOUNT @size
		SELECT
			t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.aprove,t1.userid,t1.author,
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
				t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.aprove,t1.userid,t1.author,
				(select count(t2.docid) from thelp_docattachs t2 where t2.docid=t1.docid) as attachscount,
				(select count(1) from thelp_mastercomment where docid=t1.docid) as mastercommentcount
			FROM
				thelp_documents t1			
			where deletetag=1 and t1.publishdisplay=1 AND t1.aprove=@aprove and (t1.pubcategoryid=@categoryid or t1.pubcategoryid in (select pubcategoryid from pub_doc_category where parentid=@categoryid))
			order by t1.createdatetime desc
	
END





GO
