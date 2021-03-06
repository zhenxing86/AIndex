USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themesetting_GetThemeAndStyle]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-16
-- Description:	获取站点的模板名和风格名
-- =============================================
CREATE PROCEDURE [dbo].[site_themesetting_GetThemeAndStyle]
@siteid int
AS
BEGIN
	SELECT s.siteid,'UseSiteID'=l.siteid,s.themeid,s.styleid,'ThemeTitle'=l.title,
	'StyleTitle'=(SELECT title FROM site_themestyle WHERE styleid=s.styleid AND themeid=l.themeid) 
	FROM site_themesetting s,site_themelist l
	WHERE s.themeid=l.themeid AND s.siteid=@siteid AND iscurrent=1
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themesetting_GetThemeAndStyle', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
