USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[audit_CurrentMonth_SMS_content_GetModel]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Create date: 2013-07-02
-- Description:	
-- =============================================

CREATE PROCEDURE [dbo].[audit_CurrentMonth_SMS_content_GetModel]
	@taskid VARCHAR(500)
AS
BEGIN
	SET NOCOUNT ON;
	select taskid,smscontent,Sendusercount from audit_sms_batch where taskid=@taskid
  
END



GO
