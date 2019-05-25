USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[delete_SMS]    Script Date: 07/08/2013 16:59:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      Master谭
-- Create date: 2013-05-30
-- Description:	过程 用于删除待发送短信
-- Paradef: 
-- Memo:	result -1失败，1成功
	exec delete_SMS 67
*/ 
alter PROCEDURE [dbo].[delete_SMS_All] 
	@taskid int
AS 
BEGIN

declare @content varchar(1000),@sendtime datetime,@kid int,@sender int,@smsdelcount int

select  @content=smscontent,
		@sendtime=sendtime,
		@kid=kid,
		@sender=sender
	from sms_batch where taskid=@taskid
	
declare @taskdt TABLE(tid int)	

insert into @taskdt(tid)
select taskid 
	from sms_batch
	where	
		smscontent=@content 
		and sendtime=@sendtime
		and kid=@kid
		and sender=@sender

select @smsdelcount=SUM(sendsmscount) 
			from sms_batch
				where	
					smscontent=@content 
					and sendtime=@sendtime
					and kid=@kid
					and sender=@sender 		


  Begin tran  
	BEGIN TRY  
		delete sms_batch from @taskdt
			where tid = taskid and sendtime > getdate()
			
		if @@ROWCOUNT = 0
		BEGIN
			Commit tran 
			SELECT -1 result
			RETURN
		END
		
		delete sms_message_temp 
			from @taskdt
			where tid = taskid 
				and sendtime > getdate()
				
		update KWebCMS.dbo.site_config 
			set smsnum = sc.smsnum + isnull(@smsdelcount, 0)
				from KWebCMS.dbo.site_config sc
					where sc.siteid=@kid
									
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran                          
		SELECT -1 result
		Return        
	end Catch 
	   
	SELECT 1 result

END    
GO
--[delete_SMS_All] 8764

