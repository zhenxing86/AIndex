USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_GetListByTitleAndDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-26
-- Description:	分页读取门户分类文章数据
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_GetListByTitleAndDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@categoryid int,
@title nvarchar(50),
@page int,
@size int
AS
BEGIN
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
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content
		WHERE categoryid=@categoryid and deletetag = 1
		AND (createdatetime BETWEEN @startdatetime AND @enddatetime)
		AND [contentid] NOT IN (SELECT contentid FROM mh_subcontent_relation)
		AND	(title LIKE '%'+@title+'%')
		ORDER by contentid DESC

		SET ROWCOUNT @size
		SELECT c.*,d.status as showstatus FROM cms_content c join @tmptable ON c.[contentid]=tmptableid 
		left join mh_doc_content_relation d on c.[contentid]=d.[contentid]
		WHERE row > @ignore and c.deletetag = 1
		ORDER BY orderno DESC,c.contentid DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT c.*,d.status as showstatus FROM cms_content c,mh_doc_content_relation d
		WHERE categoryid=@categoryid and c.deletetag = 1
		AND (createdatetime BETWEEN @startdatetime AND @enddatetime)
		AND c.[contentid] NOT IN (SELECT contentid FROM mh_subcontent_relation)
		AND c.[contentid]=d.[contentid]
		AND	(title LIKE '%'+@title+'%')
		ORDER by c.contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_GetListByTitleAndDateTime', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_GetListByTitleAndDateTime', @level2type=N'PARAMETER',@level2name=N'@page'
GO
