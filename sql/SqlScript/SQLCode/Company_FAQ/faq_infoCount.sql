USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[faq_infoCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[faq_infoCount]

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM faq_relation WHERE status=1),0)
RETURN @RESULT


GO
