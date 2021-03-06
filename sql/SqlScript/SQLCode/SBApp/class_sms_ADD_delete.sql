USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_ADD_delete]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--insert into sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)values('13682238844',5,'check from tel sms',getdate(),18,88,getdate(),0,0);
--insert into sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)values('18924130355',5,'check from tel sms',getdate(),18,88,getdate(),0,0);

--select pid from blogapp..permissionsetting where ptype=21
------------------------------------
--用途：短信发送
--项目名称：classhomepage
--说明：select * from sms_message where status=6 and cid=40118 order by smsid desc
--update sms_message set status=0 where status=6 and cid=40118 order by smsid desc
--时间：2009-4-15 22:54:31
------------------------------------
CREATE PROCEDURE [dbo].[class_sms_ADD_delete]
@content varchar(500) ,
@senderuserid int ,
@recuserid int ,
@sendtime datetime ,
@istime int,
@smstype int
 AS 
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
--BEGIN TRANSACTION

declare @smsnum int
declare @kid int
declare @classid int
declare @recmobile nvarchar(200)
declare @guid varchar(50)
declare @smsid int
declare @portstatus int
set @portstatus=0
declare @city int

	-- step 1  判断有无超过短信数量
	-- step 1.1  检查园短信量
	-- step 1.2  检查个人短信量
declare @isymportstatus int
declare @smssign nvarchar(10)
set @smssign=''
	select @kid=kid from BasicData.dbo.[user] where userid=@recuserid
select @isymportstatus=pid from blogapp..permissionsetting where kid=@kid and ptype=21
	select top 1 @classid=cid from BasicData.dbo.user_class where userid=@recuserid

	if(@isymportstatus>0)
	begin
		set @portstatus=5
		select @smssign=smssign from sms_sign where kid=@kid
	end


declare @curyear int
declare @curmonth int
set @curyear=datepart(year,getdate())
set @curmonth=datepart(month,getdate())

declare @kname nvarchar(50)
declare @area int
declare @province int

if(len(@content)>63)
begin
	update KWebCMS.dbo.site_config set smsnum=smsnum-2 where siteid = @kid
--	IF EXISTS(select 1 from reportapp..rep_smscount where kid=@kid and [year] = @curyear and [month] = @curmonth)
--	BEGIN
--		update reportapp..rep_smscount set smscount=smscount+2 where kid=@kid and [year] = @curyear and [month] = @curmonth
--	end
--	else
--	begin
--		select @kname=kname ,@area=city,@province=privince from basicdata..kindergarten where kid=@kid
--		insert into reportapp..rep_smscount(kid,kname,area,smscount,childcount,[year],[month],province)
--		values(@kid,@kname,@area,2,0,@curyear,@curmonth,@province)
--	end
end
else
begin
    update KWebCMS.dbo.site_config set smsnum=smsnum-1 where siteid = @kid
--	IF EXISTS(select 1 from reportapp..rep_smscount where kid=@kid and [year] = @curyear and [month] = @curmonth)
--	BEGIN
--		update reportapp..rep_smscount set smscount=smscount+1 where kid=@kid and [year] = @curyear and [month] = @curmonth
--	end
--	else
--	begin
--		select @kname=kname ,@area=city,@province=privince from basicdata..kindergarten where kid=@kid
--		insert into reportapp..rep_smscount(kid,kname,area,smscount,childcount,[year],[month],province)
--		values(@kid,@kname,@area,1,0,@curyear,@curmonth,@province)
--	end
	
end

	select @recmobile=mobile from BasicData.dbo.[user] where userid=@recuserid     
	set @guid = replace(newid(), '-', '')
	IF(@istime!=1)
	BEGIN
						
	--		update KWebCMS.dbo.site_config set smsnum=smsnum-1 where siteid = @kid
			if(@portstatus=5)
			begin
				insert into sms..sms_message_ym (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)values(@Guid, @recmobile,@portstatus,@content+@smssign,getdate(),@kid,@classid,getdate(),@senderuserid,@recuserid,@smstype)
			end
			else
			begin
				insert into sms..sms_message (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)values(@Guid, @recmobile,@portstatus,@content+@smssign,getdate(),@kid,@classid,getdate(),@senderuserid,@recuserid,@smstype)
			end
	END
	ELSE
	BEGIN
			insert into sms..sms_message_temp (Guid, recMObile,Status,content,Sendtime,Kid, Cid,WriteTime, sender,recuserid,smstype)values(@Guid, @recmobile,@portstatus,@content+@smssign,@sendtime,@kid,@classid,getdate(),@senderuserid,@recuserid,@smstype)
	--		update KWebCMS.dbo.site_config set smsnum=smsnum-1 where siteid = @kid
	END
	set @smsid=@@identity
	

IF(@@ERROR<>0)
BEGIN
	--ROLLBACK TRANSACTION
	RETURN (-1)
END
ELSE
BEGIN
	--COMMIT TRANSACTION
	RETURN @smsid
END

GO
