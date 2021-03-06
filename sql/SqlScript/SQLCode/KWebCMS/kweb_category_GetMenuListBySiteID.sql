USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_category_GetMenuListBySiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-17
-- Description:	获取生成菜单的栏目列表
-- =============================================
CREATE PROCEDURE [dbo].[kweb_category_GetMenuListBySiteID]
@siteid int
AS
BEGIN
	SELECT categoryid,title,parentid,categorytype,orderno,categorycode,siteid,iconid,islist 
	FROM cms_category 
	WHERE siteid=@siteid AND categorytype NOT BETWEEN 1 AND 7
	ORDER BY parentid ASC,orderno DESC
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_category_GetMenuListBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
