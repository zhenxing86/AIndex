USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_websiteEndDate]    Script Date: 2014/11/24 22:59:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-22
-- Description:	建站服务到期列表
-- =============================================
CREATE PROCEDURE [dbo].[custom_websiteEndDate] 
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
		SELECT webSiteID
        FROM custom_webSite
        WHERE status=1 AND endDate<=DateAdd("d",10,getdate())
        AND endDate>=getdate()
        ORDER BY endDate ASC      

		SET ROWCOUNT @size
		SELECT 
         webSiteID,t1.customID as customID,customName,paymentDate,beginDate,endDate,
          payment,isProxy,proxyPayment,remark,url
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_webSite t1 ON tmptable.tmptableid=t1.webSiteID
        INNER JOIN
            custom_data
        ON custom_data.customID=t1.customID
		WHERE 
			row >@ignore
	  ORDER BY endDate ASC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
   webSiteID,custom_webSite.customID as customID,customName,paymentDate,beginDate,endDate,
        payment,isProxy,proxyPayment,remark,url
		FROM 
           custom_webSite
        INNER JOIN custom_data ON custom_data.customID=custom_webSite.customID
        WHERE status=1 AND endDate<=DateAdd("d",10,getdate())
        AND endDate>=getdate()
        ORDER BY endDate ASC 
	END

GO
