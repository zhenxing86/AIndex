USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_TestPassword]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[sp_TestPassword]
@UserID int,
@EncryptedPassword varchar(100)
AS
     DECLARE @TempID int
     SELECT @TempID = ID FROM T_Users WHERE ID = @UserID AND
	Password = @EncryptedPassword

     IF @TempID IS NULL
	RETURN 0
     ELSE
	RETURN 1
GO
