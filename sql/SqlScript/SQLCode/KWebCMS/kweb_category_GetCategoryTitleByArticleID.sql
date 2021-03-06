USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetCategoryTitleByArticleID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	根据文章 ID 取分类标题
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetCategoryTitleByArticleID]
@contentid int
AS
BEGIN
	SELECT title FROM cms_category 
	WHERE categoryid = (SELECT categoryid FROM cms_content WHERE contentid=@contentid and deletetag = 1)
END

GO
