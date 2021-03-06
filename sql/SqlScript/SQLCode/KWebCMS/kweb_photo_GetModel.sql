USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_photo_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	获取图片实体
-- =============================================
CREATE PROCEDURE [dbo].[kweb_photo_GetModel]
@photoid int
AS
BEGIN
	SELECT photoid,categoryid,albumid,title,[filename],filepath,filesize,orderno,commentcount,
	indexshow,flashshow,createdatetime,
	'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=c.categoryid),net   
	FROM cms_photo c WHERE photoid=@photoid and deletetag = 1
END

GO
