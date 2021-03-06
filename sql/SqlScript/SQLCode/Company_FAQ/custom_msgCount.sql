USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_msgCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-10
-- Description:	获取短信客户数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_msgCount]

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(customID) FROM custom_message m1
     WHERE messageID in (SELECT MAX(messageID) FROM custom_message m2
      WHERE m1.customID=m2.customID)),0)
RETURN @RESULT

GO
