USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[area_CityGet]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-5
-- Description:	获取指定省下辖市信息
-- =============================================
CREATE PROCEDURE [dbo].[area_CityGet]
@ID int
AS
SELECT 
    ID,Title,Code
FROM
    T_Area
WHERE
    [Level]=1 AND Superior=@ID


GO
