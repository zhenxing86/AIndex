USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[audit_SMS_Pass]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[audit_SMS_Pass] 
	@taskid int,
	@userid int
AS 
BEGIN

  Begin tran  
	BEGIN TRY  
	
		update audit_sms_batch 
		set [state]=1,audituserid=@userid,audittime=GETDATE()
		where taskid=@taskid
			and [state]=0
			
		-----------------------------------------------------------------------------------------
		declare 
			@content varchar(500),
			@senderuserid int ,
			@recuserid varchar(8000),
			@sendtype int,--发送方式(0按小朋友，1按老师，2按年级，3按班级，4按部门，5按职位)
			@sendtime datetime ,
			@istime int,
			@smstype int,
			@kid int
	
		select 
			@content=smscontent,
			@senderuserid=sender,
			@recuserid=recobjid,
			@sendtype=sendtype,
			@sendtime=sendtime,
			@istime=sendmode,
			@smstype=sendtype,
			@kid=kid
		 from audit_sms_batch	
		where taskid=@taskid and [state]=1
		
		
		exec [Send_SMS] @content,@senderuserid,@recuserid,@sendtype,@sendtime,@istime,@smstype,@kid
		
		------------------------------------------------------------------------------------------
		
					
		SELECT 1 result             				
		Commit tran    
	End Try      
	Begin Catch      
		Rollback tran                          
		SELECT -1 result      
	end Catch 

END    


GO
