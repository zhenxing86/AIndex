USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[rep_wisdom_detail_sync]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------
--用途：修改一条记录 
--项目名称：storybook
--说明：
--时间：2011/11/20 21:20:08
------------------------------------
CREATE PROCEDURE [dbo].[rep_wisdom_detail_sync]

 AS 
	INSERT INTO [ossrep].[dbo].[rep_wisdom_detail]
           ([privince]
           ,[city]
           ,[areaid]
           ,[kid]
           ,[kname]
           ,[userid]
           ,[username]
           ,[moneys],[buydatetime],[orderno])
select t4.privince,t4.city,t4.area,t4.kid, t4.kname,t1.userid,t2.name,t1.plus_amount,t1.actiondatetime,t1.orderno 
from payapp..order_record t1 
left join basicdata..[user] t2 on t1.userid=t2.userid
left join basicdata..kindergarten t4 on t2.kid=t4.kid
where t1.status=1 and t2.usertype=0 and t1.actiondatetime>=getdate()-1

GO
