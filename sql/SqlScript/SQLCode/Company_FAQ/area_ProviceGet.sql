USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[area_ProviceGet]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[area_ProviceGet] 

AS
SELECT 
    ID,Title
FROM
   T_Area
WHERE
   [Level]=0


GO
