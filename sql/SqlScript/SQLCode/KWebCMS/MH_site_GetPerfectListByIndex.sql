USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetPerfectListByIndex]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MH_site_GetPerfectListByIndex]  
AS  
BEGIN  
 SELECT TOP 26 s.siteid,s.[name],sitedns,accesscount,kindesc,thumbpath,title,createdatetime,kinlevel,kinimgpath  
 FROM site s JOIN kmp..t_kindergarten t   
 ON s.siteid=t.id AND t.isportalshow=1 AND s.status=1  
 JOIN site_themesetting ON s.siteid=site_themesetting.siteid   
 JOIN site_themelist ON site_themesetting.themeid=site_themelist.themeid  
 ORDER BY accesscount DESC  
END
GO
