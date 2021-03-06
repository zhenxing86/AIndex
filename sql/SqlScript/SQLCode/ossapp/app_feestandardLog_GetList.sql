USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[app_feestandardLog_GetList]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
------------------------------------  
  
------------------------------------  
CREATE PROCEDURE [dbo].[app_feestandardLog_GetList]  
@userid int  
AS   
select ID,info into #temp from dict where name in ('服务类型','套餐名称')  
  
  
select o.actiondatetime,o.termtype,a.ltime  
,(select isnull(info,'') from #temp t where t.ID=a.a1) a1  
,(select isnull(info,'') from #temp t where t.ID=a.a2) a2  
,(select isnull(info,'') from #temp t where t.ID=a.a3) a3  
,(select isnull(info,'') from #temp t where t.ID=a.a4) a4  
,(select isnull(info,'') from #temp t where t.ID=a.a5) a5  
,(select isnull(info,'') from #temp t where t.ID=a.a6) a6  
,(select isnull(info,'') from #temp t where t.ID=a.a7) a7  
,(select isnull(info,'') from #temp t where t.ID=a.a8) a8  
,(select isnull(info,'') from #temp t where t.ID=a.a9) a9  
,(select isnull(info,'') from #temp t where t.ID=a.a10) a10  
,(select isnull(info,'') from #temp t where t.ID=a.a11) a11  
,(select isnull(info,'') from #temp t where t.ID=a.a12) a12  
,(select isnull(info,'') from #temp t where t.ID=a.a13) a13  
,f.proxyprice  
 from payapp..order_record o  
left join feestandard f on f.ID=o.PayType  
left join addservice a   
 on a.kid=f.kid  
  and a.[uid]=@userid  
  and a.a1=f.a1  
where o.userid=@userid and o.[from] = '10000'  
  
  
  
  
  
  
drop table #temp  
  
GO
