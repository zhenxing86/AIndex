USE [SMS_History]
GO
/****** Object:  StoredProcedure [dbo].[rep_sms_monthstatus_D]    Script Date: 2014/11/24 23:31:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-05-23
-- Description:	
-- Paradef: 
-- Memo:
EXEC rep_sms_monthstatus_D '2012-01-01', '2012-02-02'
*/
CREATE PROCEDURE [dbo].[rep_sms_monthstatus_D]
	@bgn datetime,
	@end datetime
AS
BEGIN
SELECT	k.kname 幼儿园, 
					SUM(case when sm.STATUS = 1 and IsLongSMS = 1 THEN 2 when sm.STATUS = 1 then 1 else 0 end) as [玄武] , 
					SUM(case when sm.STATUS = 6 and IsLongSMS = 1 THEN 2 when sm.STATUS = 6 then 1 else 0 end) as [西安] , 
					SUM(case when sm.STATUS = 9 and IsLongSMS = 1 THEN 2 when sm.STATUS = 9 then 1 else 0 end) as [亿美] ,
					SUM(case when sm.STATUS IN(1,6,9) and IsLongSMS = 1 THEN 2 when sm.STATUS IN(1,6,9) then 1 else 0 end) as [总数] 
	FROM SMS_History.dbo.sms_message sm 
		inner join [BasicData].[dbo].[kindergarten] k 
			on sm.kid = k.kid
	WHERE sm.sendtime >= CONVERT(VARCHAR(7),@bgn,120) + '-01' 
		and sm.sendtime < DATEADD(MM,1,CONVERT(VARCHAR(7),@end,120) + '-01' )
	GROUP BY k.kname
	order by [总数] DESC

END

GO
