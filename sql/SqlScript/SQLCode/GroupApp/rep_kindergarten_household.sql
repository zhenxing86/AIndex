USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_household]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_household]
@id int
,@aid int
AS

create table #city
(
ID int
,title varchar(20)
,g1 int
,g2 int
,g3 int
,g4 int
)

create table #temp
(
tID int
,ttitle varchar(20)
,tg1 int
,tg2 int
,tg3 int
,tg4 int
)

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id

insert into #city(ID,title)
select ID,Title from group_baseinfo g
inner join BasicData..Area a on a.Superior=g.areaid
where g.gid=@id and (a.ID=@aid or @aid=-1) 

delete #temp
insert into #temp(tID,ttitle,tg1,tg2)
select ID,title
,sum(case when ID=r.residence then 1 else 0 end)
,count(1) from #city c
left join  BasicData..kindergarten k on c.ID=k.residence 
inner join BasicData..[user] r on r.kid= k.kid and r.usertype=0 and r.deletetag=1
group by ID,title
order by ID

update #city  set g1=0,g2=0,g3=0

update #city  set g1=tg1,g2=tg2 from #temp where tID=ID

delete #temp

insert into #temp(tID,ttitle,tg3)
select ID,title,count(u.userid) from #city c
inner join BasicData..[user] u on u.residence=c.ID 
inner join BasicData..kindergarten k on k.kid=u.kid
where k.residence<>c.ID group by ID,title


update #city  set g3=tg3 from #temp where tID=ID

delete #temp
insert into #temp(tID,ttitle,tg4)
select ID,title,(g1+g2+g3) from #city

update #city  set g4=tg4 from #temp where tID=ID

insert into #city
select count(ID),'合计',sum(g1),sum(g2),sum(g3),sum(g4) from #city

--select ID,title,g1 本地户籍在园人数,g2 本地幼儿园在园总人数,g3 本地户籍在外地入园人数,g4 合计 from #city

--幼儿园总人数，本地户籍人数，外地户籍人数，本地户籍在外地入园人数
select ID,title,g2 幼儿园总人数,g1 本地户籍人数,(g2-g1) 外地户籍人数,g3 本地户籍在外地入园人数 from #city

drop table #temp
drop table #city

GO
