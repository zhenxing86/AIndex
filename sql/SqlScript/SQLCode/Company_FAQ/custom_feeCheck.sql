USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_feeCheck]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-21
-- Description:	查询收费信息
-- =============================================
CREATE PROCEDURE [dbo].[custom_feeCheck]
@page int,
@size int,
@fromYear int,
@fromMonth int,
@toYear int,
@toMonth int,
@customID int,
@customName nvarchar(200)
AS
IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size--20

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)

		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid)
		SELECT custom_siteUseTracking.customID
        FROM custom_siteUseTracking
        INNER JOIN custom_data ON
        custom_siteUseTracking.customID=custom_data.customID
        INNER JOIN custom_webSite ON
        custom_siteUseTracking.customID=custom_webSite.customID
        WHERE pay=1 
        AND custom_siteUseTracking.customID=CASE @customID WHEN 0 THEN custom_siteUseTracking.customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'
        AND year(paymentDate)*12+month(paymentDate)>=@fromYear*12+@fromMonth
        AND year(paymentDate)*12+month(paymentDate)<=@toYear*12+@toMonth
        GROUP BY custom_siteUseTracking.customID
        ORDER BY custom_siteUseTracking.customID DESC

		SET ROWCOUNT @size
		SELECT 
            t1.customID,customName,
            (SELECT sum(payment) FROM custom_webSite WHERE customID=t1.customID) as webSitePayment,
            (SELECT MAX(paymentDate) FROM custom_webSite WHERE customID=t1.customID) as webSiteEndDate,
            (SELECT sum(payment) FROM custom_personalized WHERE customID=t1.customID) as personalizedPayment,
            url
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_siteUseTracking t1 ON tmptable.tmptableid=t1.customID
        INNER JOIN
            custom_data ON custom_data.customID=t1.customID
		WHERE 
			row >@ignore
        GROUP BY t1.customID,customName,url
        ORDER BY t1.customID DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
            custom_siteUseTracking.customID,customName,
            (SELECT sum(payment) FROM custom_webSite WHERE customID=custom_siteUseTracking.customID) as webSitePayment,
            (SELECT MAX(paymentDate) FROM custom_webSite WHERE customID=custom_siteUseTracking.customID) as webSiteEndDate,
            (SELECT sum(payment) FROM custom_personalized WHERE customID=custom_siteUseTracking.customID) as personalizedPayment,
            url
		FROM 
           custom_siteUseTracking
        INNER JOIN custom_data ON custom_data.customID=custom_siteUseTracking.customID
        INNER JOIN custom_webSite ON
        custom_siteUseTracking.customID=custom_webSite.customID
        WHERE 
        pay=1 AND custom_siteUseTracking.customID=CASE @customID WHEN 0 THEN custom_siteUseTracking.customID ELSE @customID END
        AND customName LIKE '%'+@customName+'%'
        AND year(paymentDate)*12+month(paymentDate)>=@fromYear*12+@fromMonth
        AND year(paymentDate)*12+month(paymentDate)<=@toYear*12+@toMonth
        GROUP BY custom_siteUseTracking.customID,customName,url
        ORDER BY custom_siteUseTracking.customID DESC
	END

GO
