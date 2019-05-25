USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[rep_CurrentMonth_SMS_content_detail]    Script Date: 09/25/2013 11:46:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2013-07-02
-- Description:	
-- =============================================

alter PROCEDURE [dbo].[audit_CurrentMonth_SMS_content_Update]
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
					xuanwu = Sendusercount*(xuanwu/(xuanwu+yimei))*(case when LEN(@smscontent)>63 and xuanwu > 0 then 2
									when LEN(@smscontent)<=63 and xuanwu > 0 then 1 else 0 end)
									
					 ,yimei= Sendusercount*(yimei/(xuanwu+yimei))*(case when LEN(@smscontent)>68 
					   and yimei > 0 then 2 when LEN(@smscontent)<=68 
					   and yimei > 0 then 1 else 0 end)
		 where taskid=@taskid
	
		 
	insert into AppLogs..sms_content_log(taskid,oldcontent,newcontent,douserid,dotime)
	values(@taskid,@oldcontent,@smscontent,@douid,GETDATE())
	
	update audit_sms_batch set smscontent=@smscontent
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

exec [audit_CurrentMonth_SMS_content_GetModel] 16