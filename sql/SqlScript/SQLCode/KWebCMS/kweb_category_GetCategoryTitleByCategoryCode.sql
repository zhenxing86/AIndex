USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetCategoryTitleByCategoryCode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	根据CategoryCode获取栏目标题
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetCategoryTitleByCategoryCode]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN
--	SELECT title FROM cms_category 
--	WHERE categoryid in 
--(SELECT categoryid FROM cms_category WHERE categorycode=@categorycode 
--AND (siteid=@siteid or siteid=0))

SELECT title FROM cms_category WHERE categorycode=@categorycode 
AND (siteid=@siteid or siteid=0)	

END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetCategoryTitleByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetCategoryTitleByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
