USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themeicon_GetListBySiteID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-14
-- Description:	根据SiteID得到图标列表
-- =============================================
CREATE PROCEDURE [dbo].[site_themeicon_GetListBySiteID]
@siteid int
AS
BEGIN
	SELECT DISTINCT i.iconid,i.themeid,i.title,i.thumbpath,i.createdatetime FROM site_themeicon i,site_themesetting s
	WHERE i.themeid=s.themeid AND s.iscurrent=1 AND s.siteid=@siteid
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themeicon_GetListBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
