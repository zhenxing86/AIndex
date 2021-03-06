USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_feeList]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-20
-- Description:	收费列表
-- =============================================
CREATE PROCEDURE [dbo].[custom_feeList]
@page int,
@size int
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
		SELECT customID
        FROM custom_siteUseTracking
        WHERE pay=1
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
         WHERE pay=1
        ORDER BY custom_siteUseTracking.customID DESC
	END

GO
