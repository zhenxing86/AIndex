USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetListBySearchSiteName]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站名称搜索文章
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_GetListBySearchSiteName]
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
		from cms_content,site 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE (categorycode='XW' OR categorycode='GG'))
		  AND cms_content.siteid=site.siteid 
	      AND site.name like '%'+@name+'%'		  
		  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		  AND contentid NOT IN (SELECT contentid FROM portalarticle) and cms_content.deletetag = 1
		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,[name] 
		FROM cms_content c,@tmptable,site t3
		WHERE c.siteid=t3.siteid AND c.[contentid]=tmptableid AND row > @ignore and c.deletetag = 1
    ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT cms_content.contentid,cms_content.categoryid,cms_content.content,cms_content.title,cms_content.titlecolor,cms_content.author,cms_content.createdatetime,sitedns,[name] 
		from cms_content,site 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE (categorycode='XW' OR categorycode='GG'))
		  AND cms_content.siteid=site.siteid 
	      AND site.name like '%'+@name+'%'		  
		  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
			AND contentid NOT IN (SELECT contentid FROM portalarticle) and cms_content.deletetag = 1
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT cms_content.contentid,cms_content.categoryid,cms_content.content,cms_content.title,cms_content.titlecolor,cms_content.author,cms_content.createdatetime,sitedns,[name] 
		from cms_content,site 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE (categorycode='XW' OR categorycode='GG'))
		  AND cms_content.siteid=site.siteid 
		  AND site.name like '%'+@name+'%'		  
		  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
			AND contentid NOT IN (SELECT contentid FROM portalarticle) and cms_content.deletetag = 1
		ORDER BY contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListBySearchSiteName', @level2type=N'PARAMETER',@level2name=N'@page'
GO
