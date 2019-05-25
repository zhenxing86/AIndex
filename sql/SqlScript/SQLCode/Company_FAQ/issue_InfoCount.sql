USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[issue_InfoCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-17
-- Description:	获取客户问题跟踪数量
-- =============================================
CREATE PROCEDURE [dbo].[issue_InfoCount]

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM IssueTracking WHERE status=1),0)
RETURN @RESULT


GO
