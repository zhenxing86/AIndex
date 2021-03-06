USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_content_GetArticleTitleByID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		lx
-- alter date: 2009-03-03
-- Description:	根据ContentID 获取文章标题
-- =============================================
CREATE PROCEDURE [dbo].[kweb_content_GetArticleTitleByID]
@contentid int
AS
BEGIN
	SELECT title ,author,createdatetime FROM cms_content WHERE contentid=@contentid and deletetag = 1
END

GO
