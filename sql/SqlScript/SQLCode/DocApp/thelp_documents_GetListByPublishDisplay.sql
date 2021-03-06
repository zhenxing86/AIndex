USE [DocApp]
GO
/****** Object:  StoredProcedure [dbo].[thelp_documents_GetListByPublishDisplay]    Script Date: 2014/11/24 23:00:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：查询公共文档列表
--项目名称：ZGYEYBLOG
--说明：
--时间：2008-11-20 10:36:07
------------------------------------
CREATE PROCEDURE [dbo].[thelp_documents_GetListByPublishDisplay]
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
			deletetag=1 and publishdisplay=1 AND aprove=0
		ORDER BY
			createdatetime DESC


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
END
ELSE
BEGIN
		SET ROWCOUNT @size		
			SELECT
				t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.aprove,t1.userid,t1.author
			FROM
				thelp_documents t1			
			where deletetag=1 and t1.publishdisplay=1 AND t1.aprove=0
		order by t1.createdatetime desc
	
END









GO
