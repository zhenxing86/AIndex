USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[function_InfoCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-14
-- Description:	获取fun信息数量
-- =============================================
CREATE PROCEDURE [dbo].[function_InfoCount] 

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM FunctionChangeTracking WHERE status=1),0)
RETURN @RESULT


GO
