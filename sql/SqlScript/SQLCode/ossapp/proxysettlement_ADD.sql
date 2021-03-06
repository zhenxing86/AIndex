USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_ADD]
  @kid varchar(10),
 @settlementtype varchar(200),
 @settlementname varchar(200),
 @paytype varchar(100),
 @settlementmoney int,
 @waitmoney int,
 @paytimes int,
 @abid int,
 @remark varchar(3000),
 @uid int,
 @intime datetime,
 @deletetag int
 
 AS 
	INSERT INTO [proxysettlement](
  [kid],
 [settlementtype],
 [settlementname],
 [paytype],
 [settlementmoney],
 [waitmoney],
 [paytimes],
 [abid],
 [remark],
 [uid],
 [intime],
 [deletetag]
 
	)VALUES(
	
  @kid,
 @settlementtype,
 @settlementname,
 @paytype,
 @settlementmoney,
 @waitmoney,
 @paytimes,
 @abid,
 @remark,
 @uid,
 @intime,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
