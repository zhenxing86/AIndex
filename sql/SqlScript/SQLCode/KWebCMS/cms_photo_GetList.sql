USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cms_photo_GetList]
 AS 
	SELECT 
	[photoid],[categoryid],[albumid],[title],[filename],[filepath],[filesize],[orderno],[commentcount],[indexshow],[flashshow],[createdatetime],[net]
	 FROM cms_photo
   Where deletetag = 1

GO
