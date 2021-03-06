USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[mh_cms_content_GetCountBySearchSiteID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站ID号获取文章数量
-- =============================================
CREATE PROCEDURE [dbo].[mh_cms_content_GetCountBySearchSiteID]
@siteid int
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM cms_content
	WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE (categorycode='XW' OR categorycode='GG') AND siteid IN 
						(SELECT siteid FROM site WHERE siteid=@siteid)) 
		AND contentid not in (SELECT s_contentid FROM mh_content_content_relation)
		AND title<>'幼儿园网站开通啦！欢迎家长们上网浏览！' and deletetag = 1
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'mh_cms_content_GetCountBySearchSiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
