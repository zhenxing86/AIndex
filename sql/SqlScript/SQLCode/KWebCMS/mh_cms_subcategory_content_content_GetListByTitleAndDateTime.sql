USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_subcategory_content_content_GetListByTitleAndDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-26
-- Description:	分页读取门户子分类文章数据
--exec [mh_cms_subcategory_content_GetListByTitleAndDateTime] '2009-10-01','2009-10-30',63283,11,'',1,100
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_subcategory_content_content_GetListByTitleAndDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@categoryid int,
@subcategoryid int,
@title nvarchar(50),
@page int,
@size int
AS
BEGIN
	IF(@page>=1)
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
		INSERT INTO @tmptable(tmptableid) SELECT t1.[contentid] FROM cms_content t1,mh_subcontent_relation t2
		WHERE 
		(t1.createdatetime BETWEEN @startdatetime AND @enddatetime)		
		AND t2.subcategoryid = @subcategoryid
		and t1.contentid = t2.contentid
		AND	(t1.title LIKE '%'+@title+'%') and t1.deletetag = 1
		ORDER by t1.contentid DESC

		SET ROWCOUNT @size
		SELECT c.*,d.status as showstatus FROM cms_content c join @tmptable ON c.[contentid]=tmptableid 
		left join mh_content_content_relation d on c.[contentid]=d.[s_contentid]
		WHERE row > @ignore and c.deletetag = 1
		ORDER BY orderno DESC,contentid DESC
	END
--	ELSE
--	BEGIN
--		SET ROWCOUNT @size
--		SELECT t1.*,d.status as showstatus  FROM cms_content t1,mh_subcontent_relation t2,mh_content_content_relation d
--		WHERE 
--		(t1.createdatetime BETWEEN @startdatetime AND @enddatetime)	
--		and t1.contentid=t2.contentid
--		AND t2.subcategoryid = @subcategoryid	
--		AND t1.[contentid]=d.[s_contentid]
--		AND	(t1.title LIKE '%'+@title+'%')
--		ORDER by contentid DESC
--	END
END

GO
