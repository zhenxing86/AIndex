USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_area]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_area]
@ty int
,@id int
,@aid int
as 

create table #temp
(
ID varchar(50)
,Title varchar(200)
,g1 int
,g2 int
,g3 int
,g4 int
,g5 int
,g6 int
,g7 int
,g8 int
,g9 int
,g10 int
,g11 int
)

create table #temptable
(
ID varchar(50)
,Title varchar(200)
,opentype int
,citytype int
,Kintype int
)
--托班,小班,中班,大班,学前班

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id



if(@gkid=0)
begin
insert into #temptable
select a.ID,a.Title
,opentype
,citytype
,Kintype
from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
where g.gid=@id and (a.ID=@aid or @aid=-1)
end
else
begin

insert into #temptable
select a.ID,a.Title
,opentype
,citytype
,Kintype
from dbo.group_partinfo p 
inner join BasicData..kindergarten n on n.kid=p_kid
inner join BasicData..Area a on a.ID=area
where g_kid=@id and p.deletetag=1 

end


insert into #temp(ID,Title,g1,g2,g3,g4,g5,g6,g7,g8,g9,g10,g11)
select ID,Title
,sum(case when opentype=1 then 1 else 0 end) 教育部门办
,sum(case when opentype=2 then 1 else 0 end) 集体办
,sum(case when opentype=3 then 1 else 0 end) 民办
,sum(case when opentype=4 then 1 else 0 end) 其它部门办
,sum(case when citytype=5 then 1 else 0 end) 城市
,sum(case when citytype=6 then 1 else 0 end) 县镇
,sum(case when citytype=7 then 1 else 0 end) 农村
,sum(case when Kintype=8 then 1 else 0 end) 幼儿园
,sum(case when Kintype=9 then 1 else 0 end) 独立设置少数民族幼儿园
,sum(case when Kintype=10 then 1 else 0 end) 独立设置学前班
,count(1)
 from #temptable group by ID,Title

insert into #temp
select count(Title),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7),sum(g8),sum(g9),sum(g10),sum(g11) from #temp

select ID,Title,g1 教育部门办,g2 集体办,g3 民办,g4 其它部门办,g5 城市,g6 县镇,g7 农村,g8 幼儿园,g9 独立设置少数民族幼儿园,g10 独立设置学前班,g11 合计 from #temp

drop table #temptable
drop table #temp

GO
