USE [ossapp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kin_remind]    Script Date: 2014/11/24 23:22:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[rep_kin_remind]
@uid int
,@cuid int
as

declare @usertype int,@roleid int,@bid int,@duty varchar(20)
select @usertype=usertype,@roleid=roleid,@bid=bid,@duty=duty from users u
inner join [role] r on u.roleid=r.ID
 where u.ID=@uid


create table #ulist
(puid int)


insert into #ulist(puid) values (@uid)

insert into #ulist(puid)
select ID from users where seruid=@uid

insert into #ulist(puid)
select cuid from users_belong where puid=@uid  and deletetag=1

if(@usertype=0 and @bid>0)
begin

insert into #ulist(puid)
select ID from users where bid=@bid and deletetag=1 and ID not in (select puid from #ulist)
end

select u.puid,[name]
,sum(case when r.deletetag=1  then 1 else 0 end) 待
,sum(case when r.deletetag=0 then 1 else 0 end) 已
,count(r.ID) 全
 from #ulist u
inner join users s on u.puid=s.ID
left join remindlog r on u.puid=r.uid
group by u.puid,[name]
order by u.puid,[name]


--select u.puid,[name],r.result
--,sum(case when r.deletetag=1  then 1 else 0 end) 待
--,sum(case when r.deletetag=0 then 1 else 0 end) 已
--,count(r.ID) 全
-- from #ulist u
--inner join users s on u.puid=s.ID
--left join remindlog r on u.puid=r.uid
--group by u.puid,[name],r.result 
--order by u.puid,[name]






drop table #ulist



GO
