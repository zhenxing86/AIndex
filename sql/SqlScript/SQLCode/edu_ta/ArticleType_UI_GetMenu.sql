USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[ArticleType_UI_GetMenu]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[ArticleType_UI_GetMenu]

 AS 

SELECT 
	0      ,[ID]    ,[parentid]    ,[articleTypeName]    ,[describe]    ,[level]    ,[contentype]    ,[createuserid]    ,[createtime]    ,[webDictID]    ,[orderby]    ,[deletefag]  	 FROM [ArticleType]  where deletefag=1

and parentid=0 order by orderby







GO
