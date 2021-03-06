USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_GetTitleListByCategorycode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-05
-- Description:	根据分类代号和站点ID获取分类ID
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_GetTitleListByCategorycode]
@siteid int,
@categorycode nvarchar(20)
AS
BEGIN
	SELECT categoryid,title FROM cms_category WHERE (siteid=@siteid or siteid=0) AND categorycode=@categorycode ORDER BY createdatetime DESC
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetTitleListByCategorycode', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetTitleListByCategorycode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
