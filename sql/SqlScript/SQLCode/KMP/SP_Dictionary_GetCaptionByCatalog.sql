USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Dictionary_GetCaptionByCatalog]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_Dictionary_GetCaptionByCatalog]
	@Catalog	int
 AS 
	SELECT 
	Caption
	 FROM T_Dictionary WHERE ID =@Catalog
GO
