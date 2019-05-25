USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoName]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-19
-- Description:	获取客户名称
-- =============================================
CREATE PROCEDURE [dbo].[custom_InfoName]
@customID int
AS
SELECT
    customName
FROM
    custom_data
INNER JOIN
    custom_siteUseTracking
ON custom_data.customID=custom_siteUseTracking.customID
WHERE
    custom_data.customID=@customID AND pay=1


GO
