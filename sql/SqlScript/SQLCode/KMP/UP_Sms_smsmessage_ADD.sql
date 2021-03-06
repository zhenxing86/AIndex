USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[UP_Sms_smsmessage_ADD]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[UP_Sms_smsmessage_ADD]
@id int output,
@Recmobile varchar(50) ,
@Content varchar(200) ,
@Sender int ,
@Status int ,
@Recuserid int ,
@SendTime datetime ,
@Resultdesc varchar (100) output
 AS 

declare @smsnum int
declare @currNum int
declare @kid int
declare @classid int

	-- step 1  判断有无超过短信数量
	-- step 1.1  检查园短信量
	-- step 1.2  检查个人短信量

	select @kid=kindergartenid, @classid = classid from t_child where userid=@recuserid
	if @kid is null
		select @kid=kindergartenid from t_staffer  where userid=@recuserid
	if @classid is null
		select top 1 @classid = classid from t_stafferclass where userid = @recuserid
	if @kid is null
		begin
			select 	@Resultdesc='短信发送失败！[ 无法定位到相关幼儿园！ ]'
			return
		end
	select @smsnum=smsnum from t_kindergarten where id=@kid
	if @smsnum is null or @smsnum =0
		begin
			select 	@Resultdesc='短信发送失败！[ 短信数量不足！]'
			return
		end
		
	select @currnum=count(*) from sms_usermobile where userid=@Recuserid
	if @currnum>@smsnum
		begin
			select 	@Resultdesc='短信发送失败！[ 短信数量不足！]'
			return
		end

	if not exists(select * from sms_usermobile where userid=@recuserid)
		begin
			select 	@Resultdesc='短信发送失败！[ 无绑定手机信息！]'
			return
		end
	
	INSERT INTO Sms_smsmessage([Recmobile],[Content],[Sender],[Status],[Recuserid],[SendTime])
	select mobile,@Content,@Sender,0,@recuserid,@SendTime
	from sms_usermobile where userid=@recuserid

	select @Recmobile=mobile from sms_usermobile where userid=@recuserid 
	exec SMS_AddSmsMessageXW @RecMobile, @Content, @kid, @classid,@Sender,@RecUserID,@SendTime

	update t_kindergarten set smsnum=smsnum-1 where id = @kid

	--发短信的同时将发送邮件
	exec mail_add @Sender, '手机短信', @Recuserid, @Content

	IF EXISTS(select * from blog..bloguserkmpuser where kmpuserid=@RecUserID)
	BEGIN
		DECLARE @recbloguserid int
		DECLARE @senderbloguserid int
		SELECT @recbloguserid=bloguserid from blog..bloguserkmpuser where kmpuserid=@recuserid
		SELECT @senderbloguserid=bloguserid from blog..bloguserkmpuser where kmpuserid=@Sender
		EXEC blog..[blog_messagebox_ADD] @recbloguserid,@senderbloguserid,'手机短信',@Content,0
	END

	SET @id = @@IDENTITY
	select 	@Resultdesc=''







GO
