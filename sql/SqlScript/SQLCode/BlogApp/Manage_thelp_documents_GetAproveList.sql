USE [BlogApp]
GO
/****** Object:  StoredProcedure [dbo].[Manage_thelp_documents_GetAproveList]    Script Date: 2014/11/25 11:50:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：查询已审核公共文档 
--项目名称：Manage
--说明：
--时间：2009-7-2 22:19:17
------------------------------------
CREATE PROCEDURE [dbo].[Manage_thelp_documents_GetAproveList]
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
	
	IF(@categoryid=-1)
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE
			aprove=1 AND publishdisplay=1  
		ORDER BY
			createdatetime DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @prep
		INSERT INTO @documents(docid)
		SELECT
			docid
		FROM
			thelp_documents
		WHERE
			aprove=1 AND publishdisplay=1 AND (pubcategoryid=@categoryid or pubcategoryid in (select pubcategoryid from pub_doc_category where parentid=@categoryid))			
		ORDER BY
			createdatetime DESC
	END

		SET ROWCOUNT @size
		SELECT
			t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.aprove,t1.userid,t1.author			
		FROM
			@documents as predocuments
		INNER JOIN
			thelp_documents t1
		ON
			predocuments.docid = t1.docid		
		WHERE
			row > @ignore
			ORDER BY t1.createdatetime DESC
END
ELSE
BEGIN
	IF(@categoryid=-1)
	BEGIN
		SET ROWCOUNT @size		
			SELECT				t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.aprove,t1.userid,t1.author
			FROM
				thelp_documents t1			
			where t1.publishdisplay=1 AND t1.aprove=1 
			order by t1.createdatetime desc
	END
	ELSE
	BEGIN
			SET ROWCOUNT @size		
			SELECT
				t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.aprove,t1.userid,t1.author
			FROM
				thelp_documents t1			
			where t1.publishdisplay=1 AND t1.aprove=1 AND (t1.pubcategoryid=@categoryid or t1.pubcategoryid in (select pubcategoryid from pub_doc_category where parentid=@categoryid))
			ORDER BY t1.createdatetime DESC
	END
END




GO
