USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Dictionary_GetList]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Dictionary_GetList]
 AS 
	SELECT 
	[ID],[Caption],[Code],[Catalog]
	 FROM T_Dictionary
GO
