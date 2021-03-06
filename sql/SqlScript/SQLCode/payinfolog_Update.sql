USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfolog_Update]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--update
------------------------------------
CREATE PROCEDURE [dbo].[payinfolog_Update]
 @ID int,
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

begin tran

if(@paytype='维护费')
begin
update  kinbaseinfo  set expiretime=@lasttime where kid=@kid
end


	UPDATE [payinfolog] SET 
  [pid] = @pid,
 [kid] = @kid,
 [kname] = @kname,
 [payby] = @payby,
 [paytype] = @paytype,
 [money] = @money,
 [paytime] = @paytime,
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





UPDATE [payinfo] SET 
  [kid] = @kid,
 [kname] = @kname,
 [payby] = @payby,
 [paytype] = @paytype,
 [money] = @money,
 [paytime] = @paytime,
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

 	 WHERE ID=@pid 


if @@error<>0 
begin 
rollback tran
end
else 
begin
commit tran
end


GO
