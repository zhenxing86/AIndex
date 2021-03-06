USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[proxysettlement_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[proxysettlement_Update]
 @ID int,
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
	UPDATE [proxysettlement] SET 
  [kid] = @kid,
 [settlementtype] = @settlementtype,
 [settlementname] = @settlementname,
 [paytype] = @paytype,
 [settlementmoney] = @settlementmoney,
 [waitmoney] = @waitmoney,
 [paytimes] = @paytimes,
 [abid] = @abid,
 [remark] = @remark,
 [uid] = @uid,
 [intime] = @intime,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 



GO
