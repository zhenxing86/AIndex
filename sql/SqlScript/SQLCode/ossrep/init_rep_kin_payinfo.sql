USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_kin_payinfo]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_rep_kin_payinfo]
 AS

create table #temp
(
kid int
,kname nvarchar(100)
,lastpaytime datetime
,lasttime datetime
,areaid int
,abid int
,bfid int
,province int
,city int
,[status] nvarchar(50)
)

insert into #temp(kid,kname,lastpaytime,lasttime,areaid,abid,bfid,province,city,[status])
select  p.kid,max(p.kname),max(paytime),max(lasttime),max(areaid),max(abid),MAX(bfid),max(province),max(city),MAX([status])
from dbo.rep_vip_new p
group by p.kid



 delete rep_kin_payinfo
 
 insert into dbo.rep_kin_payinfo(kid,kname,lastpaytime,lasttime,areaid,abid,bfid,bfcount,province,city,[status])
 select  p.kid,p.kname,lastpaytime,lasttime,areaid,abid,bfid
 ,sum(case when bf.deletetag=1 then 1 else 0 end),province,city,[status]
  from #temp p
  left join ossapp..beforefollowremark bf on bf.bf_Id=p.bfid  
 group by p.kid,p.kname,lastpaytime,lasttime,areaid,abid,bfid,province,city,[status]


 


 

 drop table #temp


GO
