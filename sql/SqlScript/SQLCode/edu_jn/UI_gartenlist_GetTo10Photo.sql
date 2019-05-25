USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetTo10Photo]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


















CREATE PROCEDURE [dbo].[UI_gartenlist_GetTo10Photo]
@areaid int,
@size int = 20
 AS 
SELECT top 10  [albumid]
      ,[title]
      ,[coverphoto],''
      ,[coverphotodatetime]
      ,[net]
      ,[kname]
  FROM dbo.gartenphotos where areaid=@areaid
order by albumid  desc





GO
