USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainSingle]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-7-15
-- Description:	获取指定一级域名信息
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainSingle] 
@domainID int
AS
		SELECT 
            domainID,kindergarten,recordNo,recordName,recordPwd,
            purchaseDate,endDate,websiteName,websitePwd,domainName,documentsNo,
            personName,personDocumentNo,phone,tel,email,address,
            payment,remark,audit
		FROM 
           custom_domain
        WHERE
           domainID=@domainID


GO
