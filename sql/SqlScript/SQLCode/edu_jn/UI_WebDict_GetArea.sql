USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_WebDict_GetArea]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[UI_WebDict_GetArea]
@areaid int
 AS 
--SELECT 	0 ,[ID]    ,[parentID]    ,[name]    ,[typeName]    ,[keyID]    ,[orderby]    ,[deletetag]  	 FROM [WebDict]  where deletetag=1
--and typeName='市区' order by orderby
 

select 
0 ,[ID]    ,superior    ,Title    ,'市区'    ,0    ,1    ,1 
 from area where superior=@areaid  





GO
