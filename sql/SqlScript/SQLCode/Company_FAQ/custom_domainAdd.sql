USE [Company_FAQ]
GO
/****** Object:  StoredProcedure [dbo].[custom_domainAdd]    Script Date: 2014/11/24 22:59:43 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      张启平
-- Create date: 2010-7-14
-- Description:	新增一级域名
-- =============================================
CREATE PROCEDURE [dbo].[custom_domainAdd] 
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
@payment int,
@remark nvarchar(200),
@audit int
AS
INSERT INTO
       custom_domain
(kindergarten,recordNo,recordName,recordPwd,
purchaseDate,endDate,websiteName,websitePwd,domainName,documentsNo,
personName,personDocumentNo,phone,tel,email,address,
payment,remark,audit,status)
VALUES
(@kindergarten,@recordNo,@recordName,@recordPwd,
@purchaseDate,@endDate,@websiteName,@websitePwd,@domainName,@documentsNo,
@personName,@personDocumentNo,@phone,@tel,@email,@address,
@payment,@remark,@audit,1)
RETURN @@IDENTITY


GO
