USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[init_addservice_vip_state]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[init_addservice_vip_state]

AS 

insert into LogData..ossapp_addservice_log
([ID] ,[kid] ,[cid] ,[uid] ,[pname] ,[describe]
,[isfree] ,[normalprice] ,[discountprice] ,[paytime]
,[ftime] ,[ltime] ,[vippaystate] ,[isproxy] ,[proxymoney]
,[proxystate] ,[proxytime] ,[proxycid]
,[a1] ,[a2] ,[a3] ,[a4] ,[a5] ,[a6] ,[a7] ,[a8]
,[userid] ,[dotime] ,[deletetag])
select [ID] ,[kid] ,[cid] ,[uid] ,[pname] ,[describe]
,[isfree] ,[normalprice] ,[discountprice] ,[paytime]
,a.[ftime] ,a.[ltime] ,[vippaystate] ,[isproxy] ,[proxymoney]
,[proxystate] ,[proxytime] ,[proxycid]
,[a1] ,[a2] ,[a3] ,[a4] ,[a5] ,[a6] ,[a7] ,[a8]
,[userid] ,[dotime] ,[deletetag]
  from addservice a
	where 
		CONVERT(VARCHAR(10),ltime,120)<CONVERT(VARCHAR(10),GETDATE(),120)
		and describe='开通' and a.deletetag=1
		
		
update c set c.vipstatus=0 from basicdata..child c
		inner join basicdata..[user] u 
			on u.userid=c.userid
		inner join basicdata..user_class uc
			on uc.userid=c.userid
		inner join basicdata..class cl
			on uc.cid=cl.cid
		left join addservice a 
			on a.[uid]=c.userid and a.deletetag=1
	where u.deletetag=1 		 
		  and u.usertype=0
		  and cl.grade<>38
		  and CONVERT(VARCHAR(10),ltime,120)<CONVERT(VARCHAR(10),GETDATE(),120)
		  and describe='开通' and vipstatus=1		
		

update addservice set 
	describe='关闭',
	normalprice=0,
	vippaystate=0
		from addservice 
			where 
				CONVERT(VARCHAR(10),ltime,120)<CONVERT(VARCHAR(10),GETDATE(),120)
				and describe='开通'





GO
