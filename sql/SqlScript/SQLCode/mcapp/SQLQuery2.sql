USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mc_sms_statistics_detail]    Script Date: 09/26/2013 10:34:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      yz
-- Create date: 
-- Description:	
-- Memo:		
Ex_Temperature_Device_Detail 12511,'2013-07-10','2013-07-10'

*/
ALTER PROCEDURE [dbo].[mc_sms_statistics_stu_detail]
	@kid int,
	@smstype int,
	@bgndate datetime,
	@enddate datetime
	
AS
BEGIN
  SET NOCOUNT ON
  select sm.content, uc.name, sm.recmobile, sm.sendtime
    from sms_mc sm
      inner join BasicData..[user_child] uc 
      on sm.recuserid = uc.userid
    where sm.kid = @kid
        and sm.smstype = @smstype
        and sm.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
        and sm.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
END

