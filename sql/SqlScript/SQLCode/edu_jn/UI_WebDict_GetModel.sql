USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_WebDict_GetModel]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[UI_WebDict_GetModel]
@id int
 AS 

SELECT 
	0 ,[ID]    ,[parentID]    ,[name]    ,[typeName]    ,[keyID]    ,[orderby]    ,[deletetag]  	 FROM [WebDict]  where deletetag=1
and ID=@id order by orderby








GO
