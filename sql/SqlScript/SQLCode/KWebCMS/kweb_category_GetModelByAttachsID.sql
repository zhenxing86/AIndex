USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetModelByAttachsID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-18
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetModelByAttachsID]
@contentattachsid int
AS
BEGIN
	SELECT c.categoryid,c.title,categorycode,c.iconid,thumbpath
	FROM cms_category c JOIN site_themeicon t
	ON c.iconid=t.iconid JOIN cms_contentattachs o
	ON c.categoryid=o.categoryid and o.deletetag = 1
	WHERE o.contentattachsid=@contentattachsid
END

GO
