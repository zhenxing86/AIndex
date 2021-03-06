USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_tendays]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-30
-- Description:	获取10天内到期站点
-- =============================================
CREATE PROCEDURE [dbo].[custom_tendays]

AS
		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint,
            tmptableendDate datetime
		)
        INSERT INTO @tmptable(tmptableid,tmptableendDate)
		SELECT customID,MAX(endDate)
        FROM custom_webSite
        GROUP BY customID

		SELECT 
          t1.customID as customID,customName,paymentDate,beginDate,endDate,
          payment,isProxy,proxyPayment,remark,url
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_webSite t1 ON tmptable.tmptableid=t1.customID
        INNER JOIN
            custom_data ON custom_data.customID=t1.customID
        WHERE status=1 AND tmptableendDate<=DateAdd("d",10,getdate())
        AND tmptableendDate>=getdate() AND
        webSiteID IN ( 
          select max(webSiteID) from custom_webSite   
            group by customID having count(customID)>=1) 
        ORDER BY t1.customID DESC

GO
