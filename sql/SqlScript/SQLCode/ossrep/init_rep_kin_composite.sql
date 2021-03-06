USE [ossrep]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_kin_composite]    Script Date: 2014/11/24 23:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE procedure [dbo].[init_rep_kin_composite]

as 


delete rep_kin_composite

insert into rep_kin_composite(kid,kname,regdatetime,infofrom,[uid],developer,[status],bf_id,rid,abid)
select k.kid,k.kname,k.regdatetime,convert(nvarchar(2),k.infofrom),u.ID,u.name,[status],MAX(b.ID),MAX(bf.ID),k.abid from ossapp..kinbaseinfo k
left join ossapp..users u on u.ID=k.developer
left join ossapp..beforefollow b on k.kid=b.kid and b.deletetag=1 
left join ossapp..beforefollowremark bf on bf.bf_Id=b.ID and bf.deletetag=1
where k.deletetag=1 
group by k.kid,k.kname,k.regdatetime,k.infofrom,u.name,[status],k.abid,u.ID
order by k.kid asc

insert into rep_kin_composite(kid,kname,regdatetime,infofrom,[uid],developer,[status],bf_id,rid,abid)
select b.kid,b.kname,b.intime,convert(nvarchar(2),r.name),u.ID,u.name,'营销客户',b.ID,MAX(bf.ID),b.bid from ossapp..beforefollow b
inner join ossapp..users u on u.ID=b.[uid]
inner join ossapp..[role] r on r.ID=u.roleid
left join ossapp..beforefollowremark bf on bf.bf_Id=b.ID and bf.deletetag=1
where b.deletetag=1 and b.kid=0
group by b.kid,b.kname,b.intime,r.name,u.name,b.ID,b.bid,u.ID




GO
