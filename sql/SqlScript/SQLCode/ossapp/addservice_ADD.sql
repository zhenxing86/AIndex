USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_ADD]    Script Date: 2014/11/24 23:22:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[addservice_ADD]
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
	INSERT INTO [addservice](
  [kid],
 [cid],
 [uid],
 [pname],
 [describe],
 [isfree],
 [normalprice],
 [discountprice],
 [paytime],
 [ftime],
 [ltime],
 vippaystate,
 [isproxy],
 [proxymoney],
 [proxystate],
 [proxytime],
 [proxycid],
 [a1],
 [a2],
 [a3],
 [a4],
 [a5],
 [a6],
 [a7],
 [a8],
 [deletetag],
 [a9],[a10],[a11],[a12],[a13]
 
	)VALUES(
	
  @kid,
 @cid,
 @uid,
 @pname,
 @describe,
 @isfree,
 @normalprice,
 @discountprice,
 @paytime,
 @ftime,
 @ltime,
 @vipstate,
 @isproxy,
 @proxymoney,
 @proxystate,
 @proxytime,
 @proxycid,
 @a1,
 @a2,
 @a3,
 @a4,
 @a5,
 @a6,
 @a7,
 @a8,
 @deletetag,
 @a9,@a10,@a11,@a12,@a13
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID


GO
