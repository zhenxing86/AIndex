USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_GetListBySearchSiteName]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站名称搜索文章
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_GetListBySearchSiteName]
@name nvarchar(50),
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
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] 
		from cms_content,cms_category,site 
		WHERE cms_content.categoryid=cms_category.categoryid and cms_content.deletetag = 1
		  AND (cms_category.categorycode='XW' OR cms_category.categorycode='GG') 
		  AND cms_category.siteid=site.siteid 
	      AND site.name like '%'+@name+'%'		  
		  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
			AND contentid not in (SELECT s_contentid FROM mh_content_content_relation)
		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,[name] 
		FROM cms_content c,@tmptable,cms_category t2,site t3
		WHERE c.categoryid=t2.categoryid AND t2.siteid=t3.siteid AND c.[contentid]=tmptableid AND row > @ignore and c.deletetag = 1
    ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT cms_content.contentid,cms_content.categoryid,cms_content.content,cms_content.title,cms_content.titlecolor,cms_content.author,cms_content.createdatetime,sitedns,[name] 
		from cms_content,cms_category,site 
		WHERE cms_content.categoryid=cms_category.categoryid and cms_content.deletetag = 1
		  AND (cms_category.categorycode='XW' OR cms_category.categorycode='GG') 
		  AND cms_category.siteid=site.siteid 
	      AND site.name like '%'+@name+'%'		  
		  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
			AND contentid not in (SELECT s_contentid FROM mh_content_content_relation)
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT cms_content.contentid,cms_content.categoryid,cms_content.content,cms_content.title,cms_content.titlecolor,cms_content.author,cms_content.createdatetime,sitedns,[name] 
		from cms_content,cms_category,site 
		WHERE cms_content.categoryid=cms_category.categoryid and cms_content.deletetag = 1
		  AND (cms_category.categorycode='XW' OR cms_category.categorycode='GG') 
		  AND cms_category.siteid=site.siteid 
		  AND site.name like '%'+@name+'%'		  
		  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
			AND contentid not in (SELECT s_contentid FROM mh_content_content_relation)
		ORDER BY contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_GetListBySearchSiteName', @level2type=N'PARAMETER',@level2name=N'@page'
GO
