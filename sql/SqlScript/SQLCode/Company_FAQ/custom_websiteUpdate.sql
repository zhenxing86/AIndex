USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteUpdate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-22
-- Description:	实现建站收费信息修改
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteUpdate]
@webSiteID int,
@customID int,
@paymentDate datetime,
@beginDate datetime,
@endDate datetime,
@payment numeric(10,2),
@isProxy bit,
@proxyPayment numeric(10,2),
@remark nvarchar(200)
AS
UPDATE
    custom_webSite
SET 
 customID=@customID,paymentDate=@paymentDate,
 beginDate=@beginDate,endDate=@endDate,payment=@payment,
 isProxy=@isProxy,proxyPayment=@proxyPayment,remark=@remark
WHERE
  webSiteID=@webSiteID
RETURN @@ROWCOUNT

GO
