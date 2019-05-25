USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainEndDate]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-17
-- Description:	一级域名到期提示
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainEndDate]
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
		SELECT domainID
        FROM custom_domain
        WHERE status=1 AND endDate<=DateAdd("d",15,getdate())
        AND endDate>=getdate()
        ORDER BY endDate ASC      

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
        WHERE status=1 AND endDate<=DateAdd("d",15,getdate())
        AND endDate>=getdate()
        ORDER BY endDate ASC 
	END


GO
