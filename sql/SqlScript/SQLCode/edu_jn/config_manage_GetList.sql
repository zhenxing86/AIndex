USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[config_manage_GetList]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--GetList
------------------------------------
CREATE PROCEDURE [dbo].[config_manage_GetList]

 AS 
SELECT [id]
      ,[appname]
      ,[configpath]
      ,[syn]
  FROM [config_manage]






GO
