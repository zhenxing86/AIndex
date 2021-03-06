USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteEndDateCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-22
-- Description:	获取到期建站数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteEndDateCount] 

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) 
   FROM custom_webSite
   WHERE status=1 AND endDate<=DateAdd("d",10,getdate()) AND endDate>=getdate()),0)
RETURN @RESULT


GO
