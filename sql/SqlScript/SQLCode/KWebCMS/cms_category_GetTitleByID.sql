USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_GetTitleByID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-04
-- Description:	根所栏目ID获取栏目标题
-- =============================================
CREATE PROCEDURE [dbo].[cms_category_GetTitleByID]
@categoryid int
AS
BEGIN
	SELECT title FROM cms_category WHERE categoryid=@categoryid
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetTitleByID', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
