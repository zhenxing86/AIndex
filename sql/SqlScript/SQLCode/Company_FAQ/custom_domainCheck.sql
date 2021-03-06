USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainCheck]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-16
-- Description:	实现一级域名查询
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainCheck] 
@page int,
@size int,
@fromYear int,
@fromMonth int,
@toYear int,
@toMonth int,
@audit int,
@kindergarten nvarchar(100)
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
		SELECT domainID
        FROM custom_domain
        WHERE 
        status=1
        AND audit=CASE @audit WHEN -1 THEN audit ELSE @audit END
        AND kindergarten LIKE '%'+@kindergarten+'%'
        AND year(purchaseDate)*12+month(purchaseDate)>=@fromYear*12+@fromMonth
        AND year(purchaseDate)*12+month(purchaseDate)<=@toYear*12+@toMonth
        ORDER BY endDate DESC

		SET ROWCOUNT @size
		SELECT 
            domainID,kindergarten,recordNo,recordName,recordPwd,
            purchaseDate,endDate,websiteName,websitePwd,domainName,documentsNo,
            personName,personDocumentNo,phone,tel,email,address,
            payment,remark,audit
		FROM 
			@tmptable AS tmptable
		INNER JOIN 
			custom_domain t1 ON tmptable.tmptableid=t1.domainID
		WHERE 
			row >@ignore
        ORDER BY endDate DESC
	
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT 
            domainID,kindergarten,recordNo,recordName,recordPwd,
            purchaseDate,endDate,websiteName,websitePwd,domainName,documentsNo,
            personName,personDocumentNo,phone,tel,email,address,
            payment,remark,audit
		FROM 
           custom_domain
        WHERE 
        status=1
        AND audit=CASE @audit WHEN -1 THEN audit ELSE @audit END
        AND kindergarten LIKE '%'+@kindergarten+'%'
        AND year(purchaseDate)*12+month(purchaseDate)>=@fromYear*12+@fromMonth
        AND year(purchaseDate)*12+month(purchaseDate)<=@toYear*12+@toMonth
        ORDER BY endDate DESC
	END


GO
