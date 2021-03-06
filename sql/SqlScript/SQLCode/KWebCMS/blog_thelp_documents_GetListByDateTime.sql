USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_thelp_documents_GetListByDateTime]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[blog_thelp_documents_GetListByDateTime]
@startdate datetime,
@enddate datetime,
@title nvarchar(30),
@content nvarchar(30),
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
			blogapp..thelp_documents
		WHERE
			publishdisplay=1 AND aprove=0 AND createdatetime BETWEEN @startdate AND @enddate
			AND docid not in (select docid from mh_doc_content_relation)
			--AND (body LIKE '%'+@content+'%')
			AND (title LIKE '%'+@title+'%')
		ORDER BY
			createdatetime asc


		SET ROWCOUNT @size
		SELECT
			t1.docid,t1.categoryid,t1.title,t1.description,t1.body,t1.classdisplay,t1.kindisplay,t1.publishdisplay,t1.createdatetime,t1.viewcount,t1.aprove,t1.userid,t1.author
		FROM
			@documents as predocuments
		INNER JOIN
			blogapp..thelp_documents t1
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
				blogapp..thelp_documents t1			
			where 
				publishdisplay=1 AND aprove=0 AND createdatetime BETWEEN @startdate AND @enddate
				AND docid not in (select docid from mh_doc_content_relation)
				--AND (body LIKE '%'+@content+'%')
				AND (title LIKE '%'+@title+'%')
		order by t1.createdatetime asc
	
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_thelp_documents_GetListByDateTime', @level2type=N'PARAMETER',@level2name=N'@page'
GO
