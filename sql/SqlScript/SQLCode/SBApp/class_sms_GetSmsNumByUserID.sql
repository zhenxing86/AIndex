USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetSmsNumByUserID]    Script Date: 2014/11/24 23:27:51 ******/
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
