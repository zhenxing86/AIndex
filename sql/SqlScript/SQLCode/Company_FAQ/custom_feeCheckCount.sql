USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_feeCheckCount]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-21
-- Description:	获取缴费查询数量
-- =============================================
CREATE PROCEDURE [dbo].[custom_feeCheckCount]
@fromYear int,
@fromMonth int,
@toYear int,
@toMonth int,
@customID int,
@customName nvarchar(100)
AS
DECLARE @RESULT INT
        SET @RESULT=ISNULL((SELECT COUNT(*) 
       		FROM 
           custom_siteUseTracking 
		WHERE pay=1 AND
        customID in
        (SELECT customID
        FROM custom_webSite
        WHERE
         year(paymentDate)*12+month(paymentDate)>=@fromYear*12+@fromMonth
        AND year(paymentDate)*12+month(paymentDate)<=@toYear*12+@toMonth
         )
),0)
        RETURN @RESULT

GO
