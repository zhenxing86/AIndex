USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_GetCountBySearchSiteName]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站名称获取图片数量
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_GetCountBySearchSiteName]
@name nvarchar(50)
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) 
	FROM cms_photo c,cms_category cc,site s
	WHERE c.categoryid=cc.categoryid and c.deletetag = 1
		AND cc.siteid=s.siteid 
		AND s.name LIKE '%'+@name+'%'
		AND photoid NOT IN (SELECT photoid FROM portalphoto)
	RETURN @count
END

GO
