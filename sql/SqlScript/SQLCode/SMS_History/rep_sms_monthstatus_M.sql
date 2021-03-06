USE [SMS_History]
GO
/****** Object:  StoredProcedure [dbo].[rep_sms_monthstatus_M]    Script Date: 2014/11/24 23:31:06 ******/
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
exec rep_sms_monthstatus_M '2013-02-01','2013-05-30'
*/
CREATE PROCEDURE [dbo].[rep_sms_monthstatus_M]
	@bgn datetime,
	@end datetime
AS
BEGIN
	SELECT	convert(VARCHAR(7),sendtime,120) [月份], 
					SUM(case when sm.STATUS = 1 and IsLongSMS = 1 THEN 2 when sm.STATUS = 1 then 1 else 0 end) as [玄武] , 
					SUM(case when sm.STATUS = 6 and IsLongSMS = 1 THEN 2 when sm.STATUS = 6 then 1 else 0 end) as [西安] , 
					SUM(case when sm.STATUS = 9 and IsLongSMS = 1 THEN 2 when sm.STATUS = 9 then 1 else 0 end) as [亿美] ,
					SUM(case when sm.STATUS IN(1,6,9) and IsLongSMS = 1 THEN 2 when sm.STATUS IN(1,6,9) then 1 else 0 end) as [总数] 
	INTO #CET
	FROM SMS_History.dbo.[sms_message] sm
		WHERE sendtime >= CONVERT(VARCHAR(7),@bgn,120)+'-01'
			and sendtime < DATEADD(MM,1,CONVERT(VARCHAR(7),@end,120)+'-01')
		GROUP BY convert(VARCHAR(7),sendtime,120)
		
	select * from #CET 
	union 
	select '合计' as 月份,	SUM([玄武]),	SUM([西安]),	SUM([亿美]),	SUM([总数])
		FROM #CET 
		order by [月份]
	DROP TABLE #CET
	
END

GO
