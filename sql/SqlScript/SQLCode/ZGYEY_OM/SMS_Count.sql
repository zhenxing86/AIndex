USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[SMS_Count]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------
--用途：
--项目名称：
--说明：
--时间：2009-3-2 15:20:13
-----------------------------------
create PROCEDURE [dbo].[SMS_Count]
@kid int,
@year int,
@month int
 AS 	
	delete reportapp.rep_smscount where [year] = @year and [month] = @month
 
	insert into reportapp..rep_smscount(kid,kname,area,smscount,childcount,[year],[month],province)
select t2.kid, t2.kname,t2.city, count(t1.smsid) smscount,count(distinct(recuserid)) childcount ,2011,10,t2.privince
from sms..sms_message t1,basicdata..kindergarten t2,basicdata..[user] t3 where t1.recuserid=t3.userid and t3.usertype=0 and t1.kid=t2.kid group by t2.kid, t2.kname,t2.city,t2.privince
order by smscount desc




GO
