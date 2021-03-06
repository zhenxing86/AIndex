USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Users_ADD]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_Users_ADD]
@ID int output,
@LoginName varchar(200) ,
@Password varchar(100) ,
@Style varchar(10) ,
@UserType int ,
@Activity int ,
@NickName varchar(50) 
 AS 
	INSERT INTO T_Users(
	[LoginName],[Password],[Style],[UserType],[Activity],[NickName]
	)VALUES(
	@LoginName,@Password,@Style,@UserType,@Activity,@NickName
	)
	SET @ID = @@IDENTITY
	RETURN 1

GO
