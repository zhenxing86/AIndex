USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainEndDateCount]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-17
-- Description:	获取一级域名到期提示数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainEndDateCount]

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) 
   FROM custom_domain 
   WHERE status=1 AND endDate<=DateAdd("d",15,getdate()) AND endDate>=getdate()),0)
RETURN @RESULT


GO
