USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themecategory_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[site_themecategory_GetList]
 AS 
	SELECT id,title,status FROM site_themecategory ORDER BY id DESC

GO
