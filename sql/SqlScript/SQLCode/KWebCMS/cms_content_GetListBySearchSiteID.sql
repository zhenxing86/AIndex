USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetListBySearchSiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站ID号搜索文章
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_GetListBySearchSiteID]
@siteid int,
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
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content 
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')	 AND siteid=@siteid)		
		AND title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid NOT IN (SELECT contentid FROM portalarticle) and deletetag = 1
		ORDER BY contentid DESC

		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,[name] 
		FROM cms_content c,@tmptable,site t3
		WHERE c.siteid=t3.siteid AND c.[contentid]=tmptableid AND row > @ignore and c.deletetag = 1
    ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name]
		FROM cms_content t1,site t3 
		WHERE t1.siteid=t3.siteid AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')	 AND t3.siteid=@siteid		
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid NOT IN (SELECT contentid FROM portalarticle) and t1.deletetag = 1
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name]
		FROM cms_content t1,site t3 
		WHERE t1.siteid=t3.siteid AND categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')	 AND t3.siteid=@siteid		
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid NOT IN (SELECT contentid FROM portalarticle) and t1.deletetag = 1
		ORDER BY contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListBySearchSiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetListBySearchSiteID', @level2type=N'PARAMETER',@level2name=N'@page'
GO
