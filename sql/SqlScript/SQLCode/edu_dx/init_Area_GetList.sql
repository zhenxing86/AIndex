USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_Area_GetList]    Script Date: 08/10/2013 10:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_Area_GetList]
 AS 
	SELECT 
	       [ID]    ,[Title]    ,[Superior]    ,[Level]    ,[Code]    ,[areanum]  	 FROM [Area]
GO
