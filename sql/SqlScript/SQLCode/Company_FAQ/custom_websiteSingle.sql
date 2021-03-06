USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteSingle]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-22
-- Description:	获取指定客户建站缴费信息
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteSingle]
@websiteID int
AS
SELECT
   webSiteID,custom_webSite.customID,customName,
   paymentDate,beginDate,endDate,payment,
   isProxy,proxyPayment,remark
FROM
   custom_webSite
INNER JOIN 
   custom_data
ON  custom_webSite.customID=custom_data.customID
WHERE webSiteID=@webSiteID


GO
