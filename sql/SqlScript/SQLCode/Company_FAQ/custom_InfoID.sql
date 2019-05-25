USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoID]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-19
-- Description:	获取客户ID
-- =============================================
CREATE PROCEDURE [dbo].[custom_InfoID] 
@customName nvarchar(100)
AS
SELECT
   custom_data.customID
FROM
   custom_data
INNER JOIN
    custom_siteUseTracking
ON custom_data.customID=custom_siteUseTracking.customID
WHERE
   customName=@customName AND pay=1


GO
