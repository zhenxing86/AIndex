USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_InfoCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-5-21
-- Description:	获取客户数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_InfoCount] 

AS
DECLARE @RESULT INT
   SET @RESULT=ISNULL((SELECT COUNT(*) FROM custom_data),0)
RETURN @RESULT


GO
