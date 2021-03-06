USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[payinfo_ADD]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------
--Add
------------------------------------
CREATE PROCEDURE [dbo].[payinfo_ADD]
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
 
 as 
 
begin tran


if(exists(select b.ID from beforefollow b inner join beforefollowremark bf on bf.bf_Id=b.ID where b.kid=@kid))
begin



if(@paytype='维护费')
begin
update  kinbaseinfo  set expiretime=@lasttime where kid=@kid
end


declare @ID int

declare @pcount int
set @pcount=0
select @pcount=ID from [payinfo] where kid = @kid and paytype=@paytype

if(@pcount>0)
begin

set @ID=@pcount

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
 	 where kid = @kid and paytype=@paytype



end
else
begin

INSERT INTO [payinfo](
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

set @ID=@@IDENTITY
end

 

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
	
 @ID,
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
	
select @ID=max(ID) from [payinfolog] where kid = @kid and paytype=@paytype


end
else
begin
set @ID=0
end


if @@error<>0 
begin 
rollback tran
end
else 
begin
commit tran
return @ID
end


GO
