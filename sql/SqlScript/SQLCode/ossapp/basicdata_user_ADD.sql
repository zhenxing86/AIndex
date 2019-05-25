USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[basicdata_user_ADD]
 @account varchar(100),
 @pwd varchar(100),
 @kid int,
 @username varchar(100)
 
 AS 
 begin
 
 INSERT INTO [basicdata_user]([account],[pwd],[kid],[username])
  VALUES(@account,@pwd,@kid,@username)

    declare @userID int
	set @userID=@@IDENTITY
	RETURN @userID
end

GO
