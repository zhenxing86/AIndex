USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_gartenphotos_GetList]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_gartenphotos_GetList]
 AS 
	SELECT 
	       [albumid]    ,[title]    ,[coverphoto]    ,[coverphotodatetime]    ,[net]    ,[kname]    ,[lastuploadtime]    ,[areaid]  	 FROM [gartenphotos]
GO
