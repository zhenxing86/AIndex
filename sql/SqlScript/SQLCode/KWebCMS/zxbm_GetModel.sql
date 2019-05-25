USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[zxbm_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[zxbm_GetModel]
@id int
AS
BEGIN
    SELECT [bmid],[siteid]
      ,[name]
      ,[sex]
      ,[birthday]
      ,[fname]
      ,[fjob]
      ,[fphone]
      ,[mname]
      ,[mjob]
      ,[mphone]
      ,[address]
      ,[oldkin]
      ,[joinclass]
      ,[memo]
   
      ,[createdatetime]
	,[homephone]
,[fzw],[mzw]
  FROM [KWebCMS].[dbo].[zxbm]
    WHERE bmid=@id
END




GO
