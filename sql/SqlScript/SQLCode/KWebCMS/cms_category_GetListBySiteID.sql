USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_category_GetListBySiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[cms_category_GetListBySiteID]
@siteid int
AS 
BEGIN
	SELECT [categoryid],[title],[description],[parentid],[categorytype],[orderno],[categorycode],[siteid],[createdatetime],[iconid]
	FROM cms_category WHERE [siteid]=@siteid or siteid=0 order by categorycode, orderno desc,createdatetime desc
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_category_GetListBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
