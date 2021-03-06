USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteImport1]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-21
-- Description:	建站收费数据导入
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteImport1]
@customID int,
@paymentDate datetime,
@payment numeric(10,2),
@remark nvarchar(200)
AS
INSERT INTO
    custom_webSite
       (customID,paymentDate,beginDate,endDate,
       payment,isProxy,proxyPayment,remark,status)
VALUES
   (@customID,@paymentDate,'2006-12-31','2007-12-31',
     @payment,0,0,@remark,1)
RETURN @@IDENTITY


GO
