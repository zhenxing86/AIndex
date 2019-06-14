USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainCount]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-15
-- Description:	获取一级域名列表数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainCount] 

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM custom_domain WHERE status=1),0)
RETURN @RESULT


GO
