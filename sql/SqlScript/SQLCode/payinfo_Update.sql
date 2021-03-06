USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfo_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[payinfo_Update]
 @ID int,
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
	UPDATE [payinfo] SET 
  [kid] = @kid,
 [kname] = @kname,
 [payby] = @payby,
 [paytype] = @paytype,
 [money] = @money,
 [paytime] = @paytime,
 [isinvoice] = @isinvoice,
 [invoicedec] = @invoicedec,
 [uid] = @uid,
 [remark] = @remark,
 [isproxy] = @isproxy,
 [proxymoney] = @proxymoney,
 [firsttime] = @firsttime,
 [lasttime] = @lasttime,
 [proxystate] = @proxystate,
 [proxytime] = @proxytime,
 [proxycid] = @proxycid,
 [deletetag] = @deletetag
 	 WHERE ID=@ID 


UPDATE [payinfolog] SET 
 
 [kid] = @kid,
 [kname] = @kname,
 [payby] = @payby,
 [paytype] = @paytype,
 [money] = @money,
 [paytime] = @paytime,
 [isinvoice] = @isinvoice,
 [invoicedec] = @invoicedec,
 [uid] = @uid,
 [remark] = @remark,
 [isproxy] = @isproxy,
 [proxymoney] = @proxymoney,
 [firsttime] = @firsttime,
 [lasttime] = @lasttime,
 [proxystate] = @proxystate,
 [proxytime] = @proxytime,
 [proxycid] = @proxycid,
 [deletetag] = @deletetag
 	 WHERE  [pid]=@ID 



GO
