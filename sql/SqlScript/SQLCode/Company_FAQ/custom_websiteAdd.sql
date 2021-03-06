USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteAdd]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-19
-- Description:	新增网站建设费用
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteAdd]
@customID int,
@paymentDate datetime,
@beginDate datetime,
@endDate datetime,
@payment numeric(10,2),
@isProxy bit,
@proxyPayment numeric(10,2),
@remark nvarchar(200)
AS
INSERT INTO
    custom_webSite
(customID,paymentDate,beginDate,endDate,payment,isProxy,
 proxyPayment,remark,status)
VALUES
(@customID,@paymentDate,@beginDate,@endDate,@payment,@isProxy,
 @proxyPayment,@remark,1)
RETURN @@ROWCOUNT

GO
