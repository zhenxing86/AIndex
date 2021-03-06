USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kindomain_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[kindomain_ADD]
  @KID int,
 @kindergarten varchar(200),
 @recordNo varchar(100),
 @recordName varchar(100),
 @recordPwd varchar(100),
 @purchaseDate datetime,
 @endDate datetime,
 @websiteName varchar(400),
 @websitePwd varchar(100),
 @domainName varchar(100),
 @documentsNo varchar(100),
 @personName varchar(100),
 @personDocumentNo varchar(100),
 @phone varchar(100),
 @tel varchar(100),
 @email varchar(100),
 @address varchar(400),
 @payment int,
 @remark varchar(400),
 @audit int,
 @status int,
 @DNSAddress varchar(100),
 @SPName varchar(100),
 @isown int
 
 AS 
	INSERT INTO [kindomain](
  [KID],
 [kindergarten],
 [recordNo],
 [recordName],
 [recordPwd],
 [purchaseDate],
 [endDate],
 [websiteName],
 [websitePwd],
 [domainName],
 [documentsNo],
 [personName],
 [personDocumentNo],
 [phone],
 [tel],
 [email],
 [address],
 [payment],
 [remark],
 [audit],
 [status],
 [DNSAddress],
 [SPName],
 [isown]
 
	)VALUES(
	
  @KID,
 @kindergarten,
 @recordNo,
 @recordName,
 @recordPwd,
 @purchaseDate,
 @endDate,
 @websiteName,
 @websitePwd,
 @domainName,
 @documentsNo,
 @personName,
 @personDocumentNo,
 @phone,
 @tel,
 @email,
 @address,
 @payment,
 @remark,
 @audit,
 @status,
 @DNSAddress,
 @SPName,
 @isown
 	
	)

    declare @id int
	set @id=@@IDENTITY
	RETURN @id



GO
