USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[users_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[users_ADD]
  @account varchar(100),
 @password varchar(100),
 @usertype int,
 @roleid int,
 @bid int,
 @name varchar(100),
 @mobile varchar(100),
 @qq varchar(100),
 @remark varchar(1000),
 @regdatetime datetime,
 @seruid int,
 @deletetag int,
 @jxsid int
 
 AS 
	INSERT INTO [users](
  [account],
 [password],
 [usertype],
 [roleid],
 [bid],
 [name],
 [mobile],
 [qq],
 [remark],
 [regdatetime],
 seruid,
 [deletetag],
 jxsid
	)VALUES(
	
  @account,
 @password,
 @usertype,
 @roleid,
 @bid,
 @name,
 @mobile,
 @qq,
 @remark,
 @regdatetime,
 @seruid,
 @deletetag,
 @jxsid
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID


GO
