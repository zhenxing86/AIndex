USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_content_GetListByTitleAndDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		along
-- Create date: 2009-12-26 select * From mh_content_content_relation where categorycode='MHXWGG'
-- Description:	分页读取门户分类文章数据
--exec [mh_cms_content_content_GetListByTitleAndDateTime] '2010-01-01', '2010-12-28',63292,'',1,10
--SELECT categorycode from cms_category where categoryid=63292
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_content_GetListByTitleAndDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@categoryid int,
@title nvarchar(50),
@page int,
@size int
AS
BEGIN

		DECLARE @categorycode nvarchar(20)
		SELECT @categorycode=categorycode from cms_category where categoryid=@categoryid and siteid=18

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
		INSERT INTO @tmptable(tmptableid) SELECT t1.[s_contentid] FROM mh_content_content_relation t1,cms_content t2
		WHERE t1.categorycode=@categorycode AND t1.s_contentid=t2.contentid
		AND (t2.createdatetime BETWEEN @startdatetime AND @enddatetime)
		AND t1.s_contentid NOT IN (SELECT contentid FROM mh_subcontent_relation)
		AND	(t2.title LIKE '%'+@title+'%') and t2.deletetag = 1
		ORDER by t1.s_contentid DESC

		SET ROWCOUNT @size
		SELECT c.*,d.status as showstatus,s.sitedns FROM cms_content c join @tmptable ON c.[contentid]=tmptableid 
		left join mh_content_content_relation d on c.[contentid]=d.[s_contentid]
		left join site s on s.siteid=c.siteid and c.deletetag = 1
		WHERE row > @ignore 
		ORDER BY c.orderno DESC,c.contentid DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT t2.*,t1.status as showstatus,s.sitedns FROM mh_content_content_relation t1,cms_content t2,site s
		WHERE t1.categorycode=@categorycode AND t1.s_contentid=t2.contentid
		AND (t2.createdatetime BETWEEN @startdatetime AND @enddatetime)
		AND t1.s_contentid NOT IN (SELECT contentid FROM mh_subcontent_relation)
		AND	(t2.title LIKE '%'+@title+'%') and t2.deletetag = 1
		and s.siteid=t2.siteid
		ORDER by t1.s_contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_content_GetListByTitleAndDateTime', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_content_GetListByTitleAndDateTime', @level2type=N'PARAMETER',@level2name=N'@page'
GO
