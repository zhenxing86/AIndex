USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetModelByCategoryCode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-18
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetModelByCategoryCode]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN
	SELECT categoryid,c.title,categorycode,c.iconid,
	'thumbpath'=(SELECT thumbpath FROM site_themeicon WHERE iconid=c.iconid)
	FROM cms_category c 
	WHERE categorycode=@categorycode AND siteid=@siteid
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetModelByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetModelByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
