USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_GetListByDateTime]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据时间搜索文章
--drop PROCEDURE cms_content_GetListByDateTime
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_GetListByDateTime]
@startdatetime Datetime,
@enddatetime Datetime,
@title nvarchar(20),
@content nvarchar(20),
@page int,
@size int
AS
BEGIN		

DECLARE @prep int,@ignore int
SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY (1, 1),
			tmptableid bigint
		)



if((len(@title)>0) and (len(@content)>0))
begin

IF(@page>1)
	BEGIN
		
		
		
	SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content 
		WHERE (createdatetime BETWEEN @startdatetime AND @enddatetime) and deletetag = 1
		AND categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		--AND ([content] LIKE '%'+@content+'%')
		AND (title LIKE '%'+@title+'%')
		ORDER BY contentid DESC

		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,[name]
		FROM cms_content c JOIN @tmptable 
		ON c.[contentid]=tmptableid 
		JOIN cms_category 
		ON cms_category.categoryid=c.categoryid 
		JOIN site
		ON site.siteid=c.siteid
		WHERE row > @ignore and c.deletetag = 1 ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime) and t1.deletetag = 1 
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t1.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		--AND ([content] LIKE '%'+@content+'%')
		AND (t1.title LIKE '%'+@title+'%')
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime)  and t1.deletetag = 1
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t1.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		--AND ([content] LIKE '%'+@content+'%')
		AND (t1.title LIKE '%'+@title+'%')
		ORDER BY contentid DESC	
	END
end
		
else if(len(@title)>0)
begin

		IF(@page>1)
	BEGIN
						

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content 
		WHERE (createdatetime BETWEEN @startdatetime AND @enddatetime) and deletetag = 1
		AND categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		--AND ([content] LIKE '%'+@content+'%')
		AND (title LIKE '%'+@title+'%')
		ORDER BY contentid DESC

		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,[name]
		FROM cms_content c JOIN @tmptable 
		ON c.[contentid]=tmptableid 
		JOIN cms_category 
		ON cms_category.categoryid=c.categoryid 
		JOIN site
		ON site.siteid=cms_category.siteid
		WHERE row > @ignore and deletetag = 1 ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime) and t1.deletetag = 1
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t1.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)			
		AND (t1.title LIKE '%'+@title+'%')
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime) and t1.deletetag = 1
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t2.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation where status!=5)		
		AND (t1.title LIKE '%'+@title+'%')
		ORDER BY contentid DESC	
	END
end
ELSE IF(len(@content)>0)
BEGIN

		IF(@page>1)
	BEGIN		

	SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content 
		WHERE (createdatetime BETWEEN @startdatetime AND @enddatetime) and deletetag = 1
		AND categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		--AND ([content] LIKE '%'+@content+'%')		
		ORDER BY contentid DESC

		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,[name]
		FROM cms_content c JOIN @tmptable 
		ON c.[contentid]=tmptableid 
		JOIN cms_category 
		ON cms_category.categoryid=c.categoryid 
		JOIN site
		ON site.siteid=c.siteid
		WHERE row > @ignore and deletetag = 1 ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime) and t1.deletetag = 1
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t1.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		--AND ([content] LIKE '%'+@content+'%')		
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime) and t1.deletetag = 1
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t1.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		--AND ([content] LIKE '%'+@content+'%')		
		ORDER BY contentid DESC	
	END
end
else
begin
	
	IF(@page>1)
	BEGIN		
		
		

	SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT [contentid] FROM cms_content 
		WHERE (createdatetime BETWEEN @startdatetime AND @enddatetime) and deletetag = 1
		AND categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)			
		ORDER BY contentid DESC

		SET ROWCOUNT @size
		SELECT c.[contentid],c.[categoryid],c.[content],c.[title],c.[titlecolor],c.[author],c.[createdatetime],sitedns,[name]
		FROM cms_content c JOIN @tmptable 
		ON c.[contentid]=tmptableid 
		JOIN cms_category 
		ON cms_category.categoryid=c.categoryid 
		JOIN site
		ON site.siteid=c.siteid
		WHERE row > @ignore and c.deletetag = 1 ORDER BY contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime) and t1.deletetag = 1
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t1.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation  where status!=5)	
		ORDER BY contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT [contentid],t1.[categoryid],[content],t1.[title],[titlecolor],[author],t1.[createdatetime],sitedns,[name] 
		FROM cms_content t1,cms_category t2,site t3
		WHERE (t1.createdatetime BETWEEN @startdatetime AND @enddatetime) and t1.deletetag = 1
		AND t1.categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode='XW' OR categorycode='GG')
		AND t1.categoryid=t2.categoryid
		AND t2.siteid=t3.siteid
		--AND contentid NOT IN (SELECT contentid FROM portalarticle)
		AND t1.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation where status!=5)	
		ORDER BY contentid DESC	
	END
end
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_GetListByDateTime', @level2type=N'PARAMETER',@level2name=N'@page'
GO
