USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_GetCategoryIDListBySiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	通过站点ID号获取分类ID号列表
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_GetCategoryIDListBySiteID]
@siteid int
AS
BEGIN
	select categoryid,title from cms_category where siteid=0 or siteid=@siteid 
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetCategoryIDListBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
