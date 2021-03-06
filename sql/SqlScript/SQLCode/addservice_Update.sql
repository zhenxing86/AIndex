USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[addservice_Update]
 @ID int,
 @kid int,
 @cid int,
 @uid int,
 @pname varchar(100),
 @describe varchar(2000),
 @isfree int,
 @normalprice int,
 @discountprice int,
 @paytime datetime,
 @ftime datetime,
 @ltime datetime,
 @vipstate int,
 @isproxy int,
 @proxymoney int,
 @proxystate int,
 @proxytime datetime,
 @proxycid int,
 @a1 int,
 @a2 int,
 @a3 int,
 @a4 int,
 @a5 int,
 @a6 int,
 @a7 int,
 @a8 int,
 @deletetag int,
 @a9 int=0,
 @a10 int=0,
 @a11 int=0,
 @a12 int=0,
 @a13 int=0
 AS 
	UPDATE [addservice] SET 
  [kid] = @kid,
 [cid] = @cid,
 [uid] = @uid,
 [pname] = @pname,
 [describe] = @describe,
 [isfree] = @isfree,
 [normalprice] = @normalprice,
 [discountprice] = @discountprice,
 [paytime] = @paytime,
 [ftime] = @ftime,
 [ltime] = @ltime,
 vippaystate = @vipstate,
 [isproxy] = @isproxy,
 [proxymoney] = @proxymoney,
 [proxystate] = @proxystate,
 [proxytime] = @proxytime,
 [proxycid] = @proxycid,
 [a1] = @a1,
 [a2] = @a2,
 [a3] = @a3,
 [a4] = @a4,
 [a5] = @a5,
 [a6] = @a6,
 [a7] = @a7,
 [a8] = @a8,
 [deletetag] = @deletetag,
 [a9] = @a9,[a10] = @a10,[a11] = @a11,[a12] = @a12,[a13] = @a13
 	 WHERE ID=@ID


GO
