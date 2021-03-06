USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[send_carefor]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-06-13
-- Description:	过程用于发送连续症状的关怀短信
-- Memo: EXEC send_carefor
*/  
CREATE PROCEDURE [dbo].[send_carefor] 
as
BEGIN
	SET NOCOUNT ON
	
	SELECT DISTINCT up.userid,up.kid,a.describe,a.zcid,up.recentupdate
	INTO #T1 
		FROM zz_counter 
			UNPIVOT (Cnt FOR zz IN(fs, ks, hlfy, pz, fx, hy))up  
			inner join zz_dict zd 
				on zd.ShortTitle = up.zz
			CROSS APPLY
				(
					select top(1) describe,id as zcid 
						from zz_carefor_dict zc 
						where zc.zzid = zd.id 
							and IsLastSend = 0 order by newid()
				)a
		where Cnt = 3	
			and recentupdate = DATEADD(DD,-1,CONVERT(varchar(10),getdate(),120))
		
	;with cet as
	( 
		SELECT DISTINCT zcid 
			FROM #T1
	)	
		UPDATE zc 
				SET IsLastSend = CASE WHEN c.zcid IS null then 0 else 1 end 
			from zz_carefor_dict zc 
				LEFT JOIN cet c 
					on zc.id = c.zcid

	insert into sms_mc
				(smstype, recuserid, recmobile, sender, content, status, sendtime, writetime, kid)
		select 9, u.userid,u.mobile,0, t1.describe,	0,getdate(),getdate(),t1.kid
			from #T1 t1		
				INNER JOIN BasicData.dbo.[user] u 
					on u.userid = t1.userid			
			WHERE commonfun.dbo.fn_cellphone(u.mobile) = 1 --只发送手机号码合法的用户

	drop table #T1

END

GO
