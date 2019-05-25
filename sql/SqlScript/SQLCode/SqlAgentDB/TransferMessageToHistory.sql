USE SqlAgentDB
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 
-- Description:	
-- Memo:		
*/
CREATE PROC TransferMessageToHistory
as
BEGIN
	SET NOCOUNT ON

	Begin tran   
	BEGIN TRY  
		insert into sms_history..sms_batch
				(taskid, sender, smscontent, Sendusercount, sendsmscount,sendtime, kid, 
					sendtype, recobjid, sendmode, xuanwu, yimei, xian, cid, writetime)
		SELECT	taskid, sender, smscontent, Sendusercount, sendsmscount, sendtime, 
						kid, sendtype, recobjid, sendmode, xuanwu, yimei, xian, cid, writetime
			FROM SMS.dbo.sms_batch 
			where sendtime < CONVERT(VARCHAR(7),GETDATE(),120)+'-01'

		DELETE SMS.dbo.sms_batch 
			where sendtime < CONVERT(VARCHAR(7),GETDATE(),120)+'-01' 

		insert into sms_history..sms_message
				(guid, smstype, recuserid, recmobile, sender, [content], 
					status, sendtime, writetime, kid, cid, code, taskid)
		SELECT  guid, smstype, recuserid, recmobile, sender, [content], 
						status, sendtime, writetime, kid, cid, code, taskid
			FROM SMS.dbo.sms_message_curmonth 
			where sendtime < CONVERT(VARCHAR(7),GETDATE(),120)+'-01'

		DELETE SMS.dbo.sms_message_curmonth 
			where sendtime < CONVERT(VARCHAR(7),GETDATE(),120)+'-01'
		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return        
	end Catch     
END