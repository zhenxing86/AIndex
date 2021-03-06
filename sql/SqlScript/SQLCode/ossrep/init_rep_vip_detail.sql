USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_vip_detail]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_rep_vip_detail]
 AS
 
delete rep_vip_detail

 insert into dbo.rep_vip_detail(kid,kname,areaid,feestandard1,feestandard2,feestandard3,feestandard4,others,a2,a3,a4,a5,a6,a7,a8)  
 select a.kid,k.kname,dbo.[GetKinArea](k.privince,k.city,k.area,0)
 ,sum(case when (a1=1201) then 1 else 0 end)
 ,sum(case when (a1=1202) then 1 else 0 end)
 ,sum(case when (a1=1203) then 1 else 0 end)
 ,sum(case when (a1=1204) then 1 else 0 end)
 ,sum(case when (ISNULL(a1,0)=0) then 1 else 0 end)
 ,sum(case when (a2>0) then 1 else 0 end)
 ,sum(case when (a3>0) then 1 else 0 end)
 ,sum(case when (a4>0) then 1 else 0 end)
 ,sum(case when (a5>0) then 1 else 0 end)
 ,sum(case when (a6>0) then 1 else 0 end)
 ,sum(case when (a7>0) then 1 else 0 end)
 ,sum(case when (a8>0) then 1 else 0 end)
  from ossapp..addservice a 
 left join ossapp..kinbaseinfo k on a.kid=k.kid
 where a.deletetag=1 and k.deletetag=1
 group by a.kid,k.kname,k.privince,k.city,k.area
 

 


GO
