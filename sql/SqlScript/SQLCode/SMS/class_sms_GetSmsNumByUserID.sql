USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetSmsNumByUserID]    Script Date: 05/14/2013 14:52:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[class_sms_GetSmsNumByUserID]
@senderuserid int
,@kid int 
 AS 
	DECLARE @smsnum int
	
	select @smsnum=smsnum from KWebCMS.dbo.site_config where siteid=@kid
	RETURN @smsnum
GO
