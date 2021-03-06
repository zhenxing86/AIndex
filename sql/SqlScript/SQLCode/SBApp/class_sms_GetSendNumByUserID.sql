USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[class_sms_GetSendNumByUserID]    Script Date: 2014/11/24 23:27:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[class_sms_GetSendNumByUserID]
@senderuserid int 
,@kid int
 AS 
 
DECLARE @smsnum int
declare @curyear int
declare @curmonth int
set @curyear=datepart(year,getdate())
set @curmonth=datepart(month,getdate())

	select @smsnum=SUM(sendsmscount) from sms_batch
		where kid=@kid   
		  AND DATEPART(yy,SendTime)=DATEPART(yy,getdate())
		  AND DATEPART(mm,SendTime)=DATEPART(mm,getdate())
	
		--SET @smsnum=(select count(1) from sms..sms_message_curmonth
		-- WHERE KID=@kid
		--  AND DATEPART(yy,SendTime)=DATEPART(yy,getdate())
		--  AND DATEPART(mm,SendTime)=DATEPART(mm,getdate()))
--+(select count(1) from kmp..t_smsmessage_xw_temp WHERE KID=@kid AND DATEPART(yy,SendTime)=DATEPART(yy,getdate()) AND DATEPART(mm,SendTime)=DATEPART(mm,getdate()))
		--select @smsnum=smscount from reportapp..rep_smscount where kid=@kid and [year]=@curyear and [month]=@curmonth

	RETURN Isnull(@smsnum, 0)

GO
