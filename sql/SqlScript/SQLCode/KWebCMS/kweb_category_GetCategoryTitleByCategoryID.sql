USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetCategoryTitleByCategoryID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	根据CategoryID获取栏目标题
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetCategoryTitleByCategoryID]
@categoryid int
AS
BEGIN
	SELECT title FROM cms_category 
	WHERE categoryid = @categoryid
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetCategoryTitleByCategoryID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
