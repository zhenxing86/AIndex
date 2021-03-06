USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_feeMonthCount]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-31
-- Description:	获取月查询数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_feeMonthCount]
@year int,
@month int
AS
DECLARE @RESULT INT
        SET @RESULT=ISNULL((SELECT COUNT(*) 
       		FROM 
         custom_webSite
		WHERE 
        year(paymentDate)*12+month(paymentDate)=@year*12+@month
           ),0)
        RETURN @RESULT

GO
