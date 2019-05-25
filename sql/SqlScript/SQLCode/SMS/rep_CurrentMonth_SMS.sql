USE [SMS]
GO
/****** Object:  StoredProcedure [dbo].[rep_CurrentMonth_SMS]    Script Date: 07/03/2013 09:33:38 ******/
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
exec rep_CurrentMonth_SMS 0,'2013-06-01', '2013-06-14',12511,382030,-1


*/ 
ALTER PROCEDURE [dbo].[rep_CurrentMonth_SMS] 
	@issended bit, -- 0已发送，1待发送
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
		select @usertype=max(case role_name when '老师' then 1 when '管理员' then 98 when '园长' then 97 end)  
		from  KWebCMS..site_user stu 
		inner join KWebCMS_Right..sac_user_role sur on sur.[user_id]=stu.[UID]
		inner join KWebCMS_Right..sac_role sr on sr.role_id=sur.role_id
		where stu.appuserid=@userid

		if(@usertype is null)
		begin
		  select @usertype = usertype 
				  from BasicData.dbo.[user] 
				  where userid = @userid
		end
		
		IF @usertype > 1	
		select sb.cid, c.cname, COUNT(1) sendnum, SUM(sb.sendsmscount - sb.Sendusercount) as LongSMS, 
					 SUM(2 * sb.Sendusercount - sb.sendsmscount) as ShortSMS, SUM(sb.sendsmscount) paynum  
			from sms_batch sb
				inner join BasicData.dbo.class c
					on sb.cid = c.cid
			where sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
				AND sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
				and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended  
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
				and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended  
				and sb.kid = @kid
			GROUP BY sb.cid, c.cname		
	END
	ELSE --查老师
	BEGIN
		select 0 cid, '老师' cname, COUNT(1) sendnum, SUM(sb.sendsmscount - sb.Sendusercount) as LongSMS, 
			 SUM(2 * sb.Sendusercount - sb.sendsmscount) as ShortSMS, SUM(sb.sendsmscount) paynum  
			from sms_batch sb
			where sb.sendtime >= CONVERT(VARCHAR(10),@bgndate,120)
				AND sb.sendtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)
				and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = @issended
				and sb.cid = 0  
				and sb.kid = @kid 
			--HAVING COUNT(1)> 0
	
	END
		
END