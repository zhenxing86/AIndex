USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[delete_SMS]    Script Date: 2014/11/24 23:27:51 ******/
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
CREATE PROCEDURE [dbo].[delete_SMS] 
	@taskid int
AS 
BEGIN
	declare @TA TABLE(sendsmscount int, kid int)
  Begin tran  
	BEGIN TRY  
		delete sms_batch  
			output deleted.sendsmscount, deleted.kid  
			INTO @TA(sendsmscount,kid) 
			where taskid = @taskid and sendtime > getdate()
			
		if @@ROWCOUNT = 0
		BEGIN
			Commit tran 
			SELECT -1 result
			RETURN
		END
		
		delete sms_message_temp 
			where taskid = @taskid  
				and sendtime > getdate()
				
		update KWebCMS.dbo.site_config 
			set smsnum = sc.smsnum + isnull(t.sendsmscount, 0)
				from KWebCMS.dbo.site_config sc
					inner join @TA t
						on t.kid = sc.siteid	
									
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
