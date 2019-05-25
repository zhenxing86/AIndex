USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_feeCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-20
-- Description:	收费列表数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_feeCount]

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM custom_siteUseTracking
       WHERE pay=1),0)
RETURN @RESULT


GO
