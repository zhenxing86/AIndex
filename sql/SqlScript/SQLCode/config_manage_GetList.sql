USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[config_manage_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--GetList
------------------------------------
create PROCEDURE [dbo].[config_manage_GetList]

 AS 
SELECT [id]
      ,[appname]
      ,[configpath]
      ,[syn]
  FROM [ossapp].[dbo].[config_manage]




GO
