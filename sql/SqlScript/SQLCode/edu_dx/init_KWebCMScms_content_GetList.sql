USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_KWebCMScms_content_GetList]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_KWebCMScms_content_GetList]
 AS 
	SELECT 
	       [contentid]    ,[title]    ,[createdatetime]    ,[kname]    ,[sitedns]    ,[areaid]  	 FROM [KWebCMScms_content]
GO
