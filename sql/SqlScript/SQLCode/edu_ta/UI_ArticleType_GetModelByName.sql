USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_ArticleType_GetModelByName]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[UI_ArticleType_GetModelByName]
@typename varchar(50)
,@areaid int
 AS 

SELECT 
	0      ,[ID]    ,[parentid]    ,[articleTypeName]    ,[describe]    ,areaid    ,[contentype]    ,icon    ,[createtime]    ,[webDictID]    ,[orderby]    ,[deletefag]  	 FROM [ArticleType]  where deletefag=1
and articleTypeName=@typename and areaid=@areaid
order by orderby







GO
