USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetPassword]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[sp_SetPassword]
@UserName varchar(50),
@EncryptedPassword varchar(100)
AS

UPDATE T_Users SET
Password = @EncryptedPassword
WHERE LoginName = @UserName
GO
