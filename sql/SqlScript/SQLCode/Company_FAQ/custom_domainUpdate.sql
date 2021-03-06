USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainUpdate]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		张启平
-- Create date: 2010-7-15
-- Description:	实现一级域名修改
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainUpdate] 
@domainID int,
@kindergarten nvarchar(100),
@domainName nvarchar(100),
@recordNo nvarchar(50),
@recordName nvarchar(50),
@recordPwd nvarchar(50),
@purchaseDate datetime,
@endDate datetime,
@websiteName nvarchar(200),
@websitePwd nvarchar(50),
@documentsNo nvarchar(50),
@personName nvarchar(50),
@personDocumentNo nvarchar(50),
@phone nvarchar(50),
@tel nvarchar(50),
@email nvarchar(50),
@address nvarchar(200),
@payment float,
@remark nvarchar(200),
@audit int
AS
UPDATE
       custom_domain
SET
kindergarten=@kindergarten,recordNo=@recordNo,recordName=@recordName,
recordPwd=@recordPwd,purchaseDate=@purchaseDate,endDate=@endDate,
websiteName=@websiteName,websitePwd=@websitePwd,domainName=@domainName,
documentsNo=@documentsNo,personName=@personName,personDocumentNo=@personDocumentNo,
phone=@phone,tel=@tel,email=@email,address=@address,
payment=@payment,remark=@remark,audit=@audit
WHERE
     domainID=@domainID
RETURN @@ROWCOUNT


GO
