USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_album_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cms_album_GetList]
 AS 
	SELECT 
	[albumid],[categoryid],[title],[searchkey],[searchdescription],[photocount],[cover],[orderno]
	 FROM cms_album
   Where deletetag = 1 

GO
