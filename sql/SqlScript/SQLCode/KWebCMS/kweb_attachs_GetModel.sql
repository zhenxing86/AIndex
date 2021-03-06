USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_attachs_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-06
-- Description:	获取附件实体
-- =============================================
CREATE PROCEDURE [dbo].[kweb_attachs_GetModel]
@contentattachsid int
AS
BEGIN
	SELECT contentattachsid,categoryid,contentid,title,filepath,[filename],filesize,viewcount,createdatetime,attachurl,
	'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=c.categoryid),
    c.net
	FROM cms_contentattachs c WHERE contentattachsid=@contentattachsid and c.deletetag = 1
END

GO
