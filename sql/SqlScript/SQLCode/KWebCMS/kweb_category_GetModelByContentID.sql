USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetModelByContentID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-16
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetModelByContentID]
@contentid int
AS
BEGIN
	SELECT c.categoryid,c.title,categorycode,c.iconid,
	'thumbpath'=(SELECT thumbpath FROM site_themeicon WHERE iconid=c.iconid)
	FROM cms_category c JOIN cms_content o
	ON c.categoryid=o.categoryid and o.deletetag = 1
	WHERE o.contentid=@contentid
END

GO
