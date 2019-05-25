USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_gartenlist_GetList]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_gartenlist_GetList]
 AS 
	SELECT 
	       [kid]    ,[kname]    ,[sitedns]    ,[mingyuan]    ,[orderby]    ,[areaid]    ,[regdatetime]    ,[actiondate]    ,[telephone]    ,[qq]    ,[opentype]    ,[citytype]    ,[kintype]    ,[mastername]    ,[address]    ,[byxz]  	
	        FROM [gartenlist]
	 where syn is null or syn<>1


GO
