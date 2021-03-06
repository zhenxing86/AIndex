USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetCountBySearchSiteName]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站名称搜索文章
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_GetCountBySearchSiteName]
@name nvarchar(50)
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*)
	from cms_content,site 
	WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE (categorycode='XW' OR categorycode='GG'))
	  and cms_content.siteid=site.siteid 
	  and site.name like '%'+@name+'%'
	  AND contentid NOT IN (SELECT contentid FROM portalarticle)
	  AND cms_content.title<>'幼儿园网站开通啦！欢迎家长们上网浏览！' and cms_content.deletetag = 1
	RETURN @count
END

GO
