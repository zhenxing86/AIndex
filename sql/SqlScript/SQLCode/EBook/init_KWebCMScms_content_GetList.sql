USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_KWebCMScms_content_GetList]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_KWebCMScms_content_GetList]
 AS 
	SELECT 
	       [contentid]    ,[title]    ,[createdatetime]    ,[kname]    ,[sitedns]    ,[areaid]  	 FROM [KWebCMScms_content]
	


GO
