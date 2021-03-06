USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteList]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-21
-- Description:	用户建站缴费情况列表
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteList]
@customID int
AS
IF EXISTS(SELECT * FROM custom_webSite WHERE customID=@customID)
SELECT
   webSiteID,customID,paymentDate,beginDate,endDate,payment,isProxy,proxyPayment,
   remark
FROM
   custom_webSite
WHERE
   customID=@customID


GO
