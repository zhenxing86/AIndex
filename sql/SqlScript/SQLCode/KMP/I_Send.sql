USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[I_Send]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[I_Send]
@mobile varchar (20),
@desc varchar (200),
@sender int,
@sendtime datetime

as 

declare @smscount int
declare @kindergartenid int
declare @classid int
	--简化版短信平台标识符:kind=10
	if @sendtime is null
		select @sendtime=getdate() 

	select  top 1 @kindergartenid=a.id from t_kindergarten a,t_staffer b,t_users c where c.id=b.userid and b.kindergartenid=a.id and c.id=@sender
	select @smscount=a.smsnum from t_kindergarten a,t_staffer b,t_users c where c.id=b.userid and b.kindergartenid=a.id and c.id=@sender
	
	select top 1 @classid = c.ClassID from t_child c where mobile = @mobile

	if @smscount is null or @smscount <1
		begin
			select '短信发送数量已超过限制,请与提供商联系!'
			return 
		end
	else
		begin
		--	insert into bbonline.dbo.t_smsmessage_wx365(guid,recmobile,content,sender,status,sendtime,kind) 
		--	values (newid(),@mobile,@desc,@sender,0,@sendtime,10)
			exec SMS_AddSmsMessageEmay @mobile, @desc, @kindergartenid, @classid
			update t_kindergarten set smsnum=smsnum-1 where id=@kindergartenid
			select ''
		end

GO
