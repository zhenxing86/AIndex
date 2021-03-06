USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[addservice_vip_GetListTag_one]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[addservice_vip_GetListTag_one] 
 @page int
,@size int
,@kid int
,@txtcid int
,@txtname varchar(200)
,@txtaccount varchar(200)
,@txttel varchar(200)
,@txtispay varchar(200)
,@txtisopen varchar(200)
,@txtftime varchar(200)
,@txtltime varchar(200)
,@txtiskin varchar(200)
 AS 

declare @cid int,@uid int
select  top 1 @cid=cid,@uid=uid from addservice where kid=@kid  and deletetag=1 order by dotime desc
if(@cid is not null)
begin

SET ROWCOUNT 1
select 1,c.cid,cname,uid,u.[name],u.mobile
,[a1],[a2],[a3],[a4],[a5],[a6],[a7],[a8] 
,'' a1
,'' a2
,'' a3
,'' a4
,'' a5
,'' a6
,'' a7
,'' a8
,isfree,normalprice,ftime,ltime,vipstatus,a.vippaystate,vippaystate,1 deletetag 
,a9,'' astr9,a10,a11,a12,a13
from  addservice a 
inner join basicdata..[user] u on a.uid=u.userid
inner join basicdata..child d on d.userid=a.uid
inner join basicdata..class c on c.cid=a.cid
where  a.uid=@uid and a.deletetag=1 and a.kid=@kid
end
else
begin
SET ROWCOUNT 1
select 1,c.cid,cname,u.userid,u.[name],u.mobile
,0 [a1],0 [a2],0 [a3],0 [a4],0 [a5],0 [a6],0 [a7],0 [a8] 
,'' a1
,'' a2
,'' a3
,'' a4
,'' a5
,'' a6
,'' a7
,'' a8
,0 lisfree,0 lnormalprice,getdate() StartDate,getdate() EndDate,0,0,0,1 deletetag 
,0 a9,'' astr9,0 a10,0 a11,0 a12,0 a13
from 
 basicdata..[user] u 
inner join basicdata..child d on d.userid=u.userid
inner join basicdata..user_class uc  on u.userid=uc.userid
inner join basicdata..class c on c.cid=uc.cid
where c.kid=@kid
end


GO
