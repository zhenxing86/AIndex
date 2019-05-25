USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[SP_Users_Update]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_Users_Update]
@ID int,
@LoginName varchar(200),
@Password varchar(100),
@Style varchar(10),
@UserType int,
@Activity int,
@NickName varchar(100)
 AS 
	UPDATE T_Users SET 
	[LoginName] = @LoginName,[Password] = @Password,[Style] = @Style,[UserType] = @UserType,[Activity] = @Activity,[NickName]=@NickName
	WHERE [ID] = @ID
GO
