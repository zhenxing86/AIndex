USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_area]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[rep_kindergarten_area]
@ty int
,@id int--本身的区域ID
,@aid int--过滤的区域ID
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
,Title nvarchar(200)
,opentype int
,citytype int
,Kintype int
)


create table #tempareaid
(
lareaid int,
lareatitle nvarchar(100)
)

declare @lever int
select @lever=[level] from Area where ID=@id

if(@aid=-1)
begin

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@id or ID=@id)

end
else
begin


insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@aid or ID=@aid)



end






if(@lever=1)
begin


if(@aid=-1 or @id=@aid)
begin



insert into #temptable
select lareaid,lareatitle,opentype
,citytype
,Kintype from #tempareaid 
inner join Area on (lareaid=ID or superior=lareaid)
left join gartenlist on ID=areaid
where (lareaid<>@ID or (lareaid=@ID and ID=@ID) )



end
else
begin

insert into #temptable
select lareaid,lareatitle
,opentype
,citytype
,Kintype
from #tempareaid 
inner join gartenlist l  on lareaid=areaid
end



end
else--@lever<>1
begin

if(@id=@aid)
begin
set @aid=-1
end

insert into #temptable
select lareaid,lareatitle
,opentype
,citytype
,Kintype
from  #tempareaid
inner join gartenlist l on lareaid=areaid
 where (lareaid=@aid or @aid=-1)

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
order by (case when id=@id or id=@aid then 1 ELSE case when Title<>'合计' then 2 else 3 end END) asc,ID asc

drop table #temptable
drop table #temp
drop table #tempareaid




GO
