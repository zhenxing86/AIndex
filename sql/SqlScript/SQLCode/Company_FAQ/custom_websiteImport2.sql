USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteImport2]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-21
-- Description:	导入建站到期日
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteImport2] 
@customID int,
@beginDate datetime,
@endDate datetime
AS
UPDATE
   custom_webSite
SET
   beginDate=@beginDate,
   endDate=@endDate
WHERE
   customID=@customID
RETURN @@ROWCOUNT


GO
