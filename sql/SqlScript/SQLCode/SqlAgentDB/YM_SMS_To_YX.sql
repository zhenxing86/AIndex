USE [SqlAgentDB]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      along
-- Create date: 2013-08-17
-- Description:	
-- Paradef: select convert(varchar(20),getdate(),120)
-- Memo:	EXEC sqlagentdb..[YX_SMS_Test]
*/
alter PROCEDURE [dbo].[YM_SMS_To_YX] 
AS
BEGIN
	SET NOCOUNT ON


	
	select guid,smstype,recuserid,recmobile,sender,replace(content,'¡¾Ó×¶ùÔ°¡¿','') as content,
		10 as [status],sendtime,writetime,kid,cid,0 as code,taskid
		into #temp	from sms..sms_message_zy_ym where status=8		
	
	INSERT INTO [SMS]..[sms_message_yx]([guid],[smstype],[recuserid],[recmobile],[sender],[content],
					[status],[sendtime],[writetime],[kid],[cid],[code],[taskid])
	select * from #temp
	
	update sms..sms_message_zy_ym set status=9 where status=8
	and smsid in(select smsid from #temp)
	
	drop table #temp
	
	
	INSERT INTO [SMS].[dbo].[sms_message_yx]([guid],[smstype],[recuserid],[recmobile],[sender],
		[content],[status],[sendtime],[writetime],[kid],[cid],[code])     
			SELECT newid(),0,0,mobile,18,verify_code,10,getdate(),getdate(),18,0,''
	FROM basicdata..verify_sms 
		where verify_status=0 

	update basicdata..verify_sms set verify_status=1 where verify_status=0
	
	
	
	SELECT [guid],[smstype],[recuserid],[recmobile],[sender],[content],10 as [status],
	[sendtime],[writetime],[kid],[cid]
	into #temp2	FROM mcapp..sms_mc 
	where status=0 and len(content)>0 and kid not in (12511)
	
	INSERT INTO [SMS].[dbo].[sms_message_yx]([guid],[smstype],[recuserid],[recmobile],[sender],[content],
				[status],[sendtime],[writetime],[kid],[cid])
				select * from #temp2
	update mcapp..sms_mc set status=1 where status=0 and smsid in(select smsid from #temp2)
	
	drop table #temp2
	
	INSERT INTO [SMS].[dbo].[sms_message_yx]([guid],[smstype],[recuserid],[recmobile],[sender],[content],
				[status],[sendtime],[writetime],[kid],[cid],[code])
	SELECT [guid],[smstype],[recuserid],[recmobile],[sender],[content],10,[sendtime],[writetime],[kid],[cid],smsid
		FROM mcapp..sms_mc 
	where status=0 and len(content)>0 and kid=12511
--		and recmobile in('18028633611','18922209598','13808828988','13682238844')
		and recmobile in('18028633611')
    -- and recmobile ='18028633611'

	update mcapp..sms_mc set status= 1 where status=0 and kid=12511
	
	

	
	
END		


