USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetCategoryIDByCategoryCode]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	根据 CategoryCode 获取 CategoryID
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetCategoryIDByCategoryCode]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid
	RETURN @count
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetCategoryIDByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetCategoryIDByCategoryCode', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
