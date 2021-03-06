USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[kindomain_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[kindomain_Update]
 @id int,
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
 
 
select 1 from [kindomain] where kid=@Kid
if(@@rowcount=0)
begin

 
	INSERT INTO [kindomain](
	id,
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




end
else
begin

	UPDATE [kindomain] SET 
 [kindergarten] = @kindergarten,
 [recordNo] = @recordNo,
 [recordName] = @recordName,
 [recordPwd] = @recordPwd,
 [purchaseDate] = @purchaseDate,
 [endDate] = @endDate,
 [websiteName] = @websiteName,
 [websitePwd] = @websitePwd,
 [domainName] = @domainName,
 [documentsNo] = @documentsNo,
 [personName] = @personName,
 [personDocumentNo] = @personDocumentNo,
 [phone] = @phone,
 [tel] = @tel,
 [email] = @email,
 [address] = @address,
 [payment] = @payment,
 [remark] = @remark,
 [audit] = @audit,
 [status] = @status,
 [DNSAddress] = @DNSAddress,
 [SPName] = @SPName,
 [isown] = @isown
 	 WHERE kid=@Kid 

end

 






GO
