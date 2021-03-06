USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_man_settime]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
-- Author:      XIE
-- Create date: 2013-05-22
-- Description:	过程用于园长短信发送时间配置
-- Paradef: @smstime int( 1 10：00， 2 10：30， 3 11：00， 4 11：30)
-- Memo:
kindergarten

EXEC mc_sms_man_settime 12511,1

*/
CREATE procedure [dbo].[mc_sms_man_settime]
	@kid int,
	@smstime int
AS
BEGIN
		update mcapp..kindergarten 
			set smstime=@smstime
			where kid = @kid 
END	

GO
