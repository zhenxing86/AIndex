USE [SMS_History]
GO
/****** Object:  StoredProcedure [dbo].[rep_HistoryMonth_SMS]    Script Date: 04/02/2014 15:41:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-05-30
-- Description:	
-- Paradef: 
-- Memo:	
exec rep_HistoryMonth_SMS '2013-05-01', '2013-05-30',12511,288556
*/ 
ALTER PROCEDURE [dbo].[rep_HistoryMonth_SMS] 
	@bgndate datetime,
	@enddate datetime,
	@kid int,
	@userid int,
	@type int = 0
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @usertype int

	IF @type = 0--查学生
	BEGIN	
	
		set @usertype=CommonFun.dbo.fn_KWebCMS_Right_max(@userid)
	
		
		IF @usertype > 1	
			select sb.cid, c.cname, COUNT(1) sendnum, SUM(sb.sendsmscount - sb.Sendusercount) as LongSMS, 
						 SUM(2 * sb.Sendusercount - sb.sendsmscount) as ShortSMS, SUM(sb.sendsmscount) paynum  
				from sms_batch sb
					inner join BasicData.dbo.class c
						on sb.cid = c.cid
				where sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
					AND sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
					and sb.kid = @kid
				GROUP BY sb.cid, c.cname
		ELSE 
			select sb.cid, c.cname, COUNT(1) sendnum, SUM(sb.sendsmscount - sb.Sendusercount) as LongSMS, 
					 SUM(2 * sb.Sendusercount - sb.sendsmscount) as ShortSMS, SUM(sb.sendsmscount) paynum  
				from sms_batch sb
					inner join BasicData.dbo.class c
						on sb.cid = c.cid
					INNER JOIN BasicData.dbo.user_class uc
						ON uc.cid = sb.cid 
						and uc.userid = @userid
				where sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
					AND sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
					and sb.kid = @kid
				GROUP BY sb.cid, c.cname
		END
		ELSE
		BEGIN
			select 0 cid, '老师' cname, COUNT(1) sendnum, SUM(sb.sendsmscount - sb.Sendusercount) as LongSMS, 
						SUM(2 * sb.Sendusercount - sb.sendsmscount) as ShortSMS, SUM(sb.sendsmscount) paynum  
				from sms_batch sb
				where sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
					AND sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
					and sb.cid = 0  
					and sb.kid = @kid
					having COUNT(1)>0
		END		
		
END