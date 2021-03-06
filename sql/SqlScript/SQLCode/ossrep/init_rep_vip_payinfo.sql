USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_vip_payinfo]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[init_rep_vip_payinfo]
 AS

delete dbo.rep_vip_payinfo

insert into rep_vip_payinfo(kid,kname,paytime,paytype,paymoney,areaid,abid,[status],lasttime,bfid,province,city)
select p.kid,k.kname,p.paytime,paytype,p.[money],dbo.[GetKinArea](k.privince,k.city,k.area,0) 
,case when infofrom='代理' then k.abid else 0 end,k.[status],k.expiretime,bf.ID
,k.privince 
,dbo.[GetKinArea](k.privince,k.city,0,0) 
from ossapp..payinfolog p
 left join ossapp..kinbaseinfo k on p.kid=k.kid
 left join ossapp..beforefollow bf on p.kid=bf.kid
  where p.deletetag=1 and k.deletetag=1


update rep_vip_payinfo set areaid=city where areaid=28


delete dbo.rep_vip_new
insert into rep_vip_new(kid,kname,paytime,paymoney,paytype,areaid,abid,[status],province,city,lasttime,bfid)
select kid,kname,min(paytime),sum(paymoney),paytype,areaid,abid,max([status]),province,city,max(lasttime),MAX(bfid) 
from rep_vip_payinfo
group by kid,kname,paytype,areaid,abid,province,city

 

GO
