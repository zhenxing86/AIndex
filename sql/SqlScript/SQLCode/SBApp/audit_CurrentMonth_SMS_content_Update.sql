USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[audit_CurrentMonth_SMS_content_Update]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Create date: 2013-07-02
-- Description:	
-- =============================================

CREATE PROCEDURE [dbo].[audit_CurrentMonth_SMS_content_Update]
	@taskid VARCHAR(500),
	@smscontent VARCHAR(1500),
	@douid int
AS
BEGIN
	SET NOCOUNT ON;
	
begin tran 
begin try  

	declare @oldcontent varchar(500),@smscount int,@Sendusercount int
	
	

	select @oldcontent=smscontent,@Sendusercount=Sendusercount from audit_sms_batch 
		 where taskid=@taskid
		 
		 
		 
	update audit_sms_batch set
					xuanwu = Sendusercount*xuanwu*(case when LEN(@smscontent)>63 and xuanwu > 0 then 2
									when LEN(@smscontent)<=63 and xuanwu > 0 then 1 else 0 end)/(xuanwu+yimei)
									
					 ,yimei= Sendusercount*yimei*(case when LEN(@smscontent)>68 
					   and yimei > 0 then 2 when LEN(@smscontent)<=68 
					   and yimei > 0 then 1 else 0 end)/(xuanwu+yimei)
		 where taskid=@taskid
	
		 
	insert into AppLogs..sms_content_log(taskid,oldcontent,newcontent,douserid,dotime)
	values(@taskid,@oldcontent,@smscontent,@douid,GETDATE())
	
	update audit_sms_batch set smscontent=@smscontent,sendsmscount=(xuanwu+yimei+xian)
		 where taskid=@taskid
		 
 select 1

commit tran
end try
begin catch
 rollback tran 
 select 0
end catch

END



GO
