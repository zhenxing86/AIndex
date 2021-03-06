USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_GetCountBySearchSiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站ID获取图片数量
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_GetCountBySearchSiteID]
@siteid int
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) 
	FROM cms_photo c,cms_category cc,site s
	WHERE c.categoryid=cc.categoryid and c.deletetag = 1
		AND cc.siteid=s.siteid 
		AND s.siteid=@siteid
		AND photoid NOT IN (SELECT photoid FROM portalphoto)
	RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_GetCountBySearchSiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
