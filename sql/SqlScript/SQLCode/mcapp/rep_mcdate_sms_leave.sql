USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_mcdate_sms_leave]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		yz	
-- Create date:  2014-7-17
-- Description:	 获取某幼儿园的离园短信发送记录
--[dbo].[rep_mcdate_sms_leave] '2014-6-16','2014-7-17',12511
-- =============================================
CREATE PROCEDURE [dbo].[rep_mcdate_sms_leave]
   @bgndate date,
   @enddate date,
   @kid int 
AS
BEGIN
	SET NOCOUNT ON;
  select recuserid,recmobile,content,sendtime,status,writetime
   from sms..sms_message_curmonth
     where kid = @kid
     and sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
     and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
     and smstype = 14
    
   union all
   
   select recuserid,recmobile,content,sendtime,status,writetime
   from sms_history..sms_message
     where kid = @kid
     and sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
     and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
     and smstype = 14
     
   union all
   
   select recuserid,recmobile,content,sendtime,status,writetime 
   from sms..sms_message_yx_temp
     where kid = @kid
     and sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
     and sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
     and smstype = 14

END

GO
