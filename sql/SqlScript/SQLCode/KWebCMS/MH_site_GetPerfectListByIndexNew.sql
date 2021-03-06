USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetPerfectListByIndexNew]    Script Date: 05/14/2013 14:43:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec MH_site_GetPerfectListByIndexNew

-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-08-13
-- Description:	获取首页优秀幼儿园列表
-- =============================================
alter PROCEDURE [dbo].[MH_site_GetPerfectListByIndexNew]
AS
BEGIN
	SELECT TOP 26 s.siteid,s.[name],sitedns,accesscount,kindesc,thumbpath,title,createdatetime,kinlevel,kinimgpath
	FROM site s JOIN site_config t 
	ON s.siteid=t.siteid AND t.isportalshow=1 AND s.status=1
	JOIN site_themesetting ON s.siteid=site_themesetting.siteid 
	JOIN site_themelist ON site_themesetting.themeid=site_themelist.themeid
	ORDER BY createdatetime DESC
END
GO
