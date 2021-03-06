USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfolog_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[payinfolog_ADD]
  @pid int,
 @kid int,
 @kname varchar(100),
 @payby varchar(50),
 @paytype varchar(200),
 @money int,
 @paytime datetime,
 @isinvoice int,
 @invoicedec varchar(500),
 @uid int,
 @remark varchar(2000),
 @isproxy int,
 @proxymoney int,
 @firsttime datetime,
 @lasttime datetime,
 @proxystate int,
 @proxytime datetime,
 @proxycid int,
 @deletetag int
 
 AS 
	INSERT INTO [payinfolog](
  [pid],
 [kid],
 [kname],
 [payby],
 [paytype],
 [money],
 [paytime],
 [isinvoice],
 [invoicedec],
 [uid],
 [remark],
 [isproxy],
 [proxymoney],
 [firsttime],
 [lasttime],
 [proxystate],
 [proxytime],
 [proxycid],
 [deletetag]
 
	)VALUES(
	
  @pid,
 @kid,
 @kname,
 @payby,
 @paytype,
 @money,
 @paytime,
 @isinvoice,
 @invoicedec,
 @uid,
 @remark,
 @isproxy,
 @proxymoney,
 @firsttime,
 @lasttime,
 @proxystate,
 @proxytime,
 @proxycid,
 @deletetag
 	
	)

    declare @ID int
	set @ID=@@IDENTITY
	RETURN @ID



GO
