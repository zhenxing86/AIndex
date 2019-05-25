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

ALTER PROCEDURE [dbo].[audit_CurrentMonth_SMS_content_GetModel]
	@taskid VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON;
	select taskid,smscontent,Sendusercount from audit_sms_batch where taskid=@taskid
  
END

GO

exec [audit_CurrentMonth_SMS_content_GetModel] 16