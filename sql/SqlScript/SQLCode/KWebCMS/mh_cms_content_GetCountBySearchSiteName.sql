USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_GetCountBySearchSiteName]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站名称搜索文章
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_GetCountBySearchSiteName]
@name nvarchar(50)
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*)
	from cms_content,cms_category,site 
	WHERE cms_content.categoryid=cms_category.categoryid 
	  and (cms_category.categorycode='XW' OR cms_category.categorycode='GG')
	  and cms_category.siteid=site.siteid 
	  and site.name like '%'+@name+'%' and cms_content.deletetag = 1
	  AND contentid not in (SELECT s_contentid FROM mh_content_content_relation)
	  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！'
	RETURN @count
END

GO
