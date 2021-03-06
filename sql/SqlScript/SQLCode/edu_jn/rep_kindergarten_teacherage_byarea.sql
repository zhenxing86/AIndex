USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacherage_byarea]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[rep_kindergarten_teacherage_byarea]
@ty int
,@id int
,@aid int
,@page int
,@size int
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
)

create table #temptable
(
ID varchar(50)
,Title varchar(200)
,birthday datetime
,nation varchar(50)
,gender varchar(50)
,age varchar(50)
)
--托班,小班,中班,大班,学前班



------------------------------------------------------------------------------------------------------
create table #tempareaid
(
lareaid int,
lareatitle nvarchar(100)
)

declare @lever int,@clever int
select @lever=[level] from Area where ID=@id
select @clever=[level] from Area where ID=@aid


if(@lever=1 or (@lever=2 and @aid=-1))--省市进来的时候显示旗下区县，区县进来@aid=-1的时候，显示街道
begin



insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@id or ID=@id)


if(@lever=1 and @aid=-1 or @id=@aid)
begin

insert into #temptable
select t.lareaid,t.lareatitle,birthday,nation,gender,0
from #tempareaid t
inner join Area a on (lareaid=ID or superior=lareaid)
inner join rep_kininfo r on a.ID=r.areaid
where (lareaid<>@ID or (lareaid=@ID and r.areaid=@ID) )
and r.usertype=1


end
else
begin

insert into #temptable
select a.lareaid,a.lareatitle,birthday,nation,gender,0
from #tempareaid a
inner join rep_kininfo r on a.lareaid=r.areaid
where  r.usertype=1

end

end


if(@aid>0)--当区域大于0的时候，表示已经选择了街道，于是显示幼儿园出来
begin

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@aid or ID=@aid)

insert into #temptable
select r.kid,r.kname,birthday,nation,gender,0
from rep_kininfo r
inner join #tempareaid a on a.lareaid=r.areaid
where  r.usertype=1


end
------------------------------------------------------------------------------------------------------



update #temptable set age=dbo.FUN_GetAge(birthday)



insert into #temp(ID,Title,g1,g2,g3,g4,g5,g6,g7,g8,g9)
select ID,Title
,sum(case when age=25 then 1 else 0 end) [25岁及以下]
,sum(case when age>25 and age<=30 then 1 else 0 end) [26-30岁]
,sum(case when age>30 and age<=35 then 1 else 0 end) [31-35岁]
,sum(case when age>35 and age<=40 then 1 else 0 end) [36-40岁]
,sum(case when age>40 and age<=45 then 1 else 0 end) [41-45岁]
,sum(case when age>45 and age<=50 then 1 else 0 end) [46-50岁]
,sum(case when age>50 and age<=55 then 1 else 0 end) [51-55岁]
,sum(case when age>55 and age<=60 then 1 else 0 end) [56-60岁]
,sum(case when age>=61 then 1 else 0 end) [61岁及以上]
 from #temptable group by ID,Title


--当市进来的时候，没有班级的街道补充进去
if(@lever=1 and (@aid=-1 or @id=@aid))
begin
insert into #temp
select ID,Title,0,0,0,0,0,0,0,0,0 from Area a
 where (@id=ID or superior=@id)
 and not exists(select 1 from #temp t where a.ID=t.ID)
end

if(@lever=2  and @aid=-1)
begin
insert into #temp
select ID,Title,0,0,0,0,0,0,0,0,0 from Area a
 where (@id=ID or superior=@id)
 and not exists(select 1 from #temp t where a.ID=t.ID)
end




insert into #temp
select count(Title),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7),sum(g8),sum(g9) from #temp


--select ID,Title,g1 [25岁及以下],g2 [26-30岁],g3 [31-35岁],g4 [36-40岁],g5 [41-45岁],g6 [46-50岁],g7 [51-55岁],g8 [56-60岁],g9 [61岁及以上] from #temp


declare @pcount int
select @pcount=count(1) from #temp

IF(@page>1)
	BEGIN
	
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			select ID from #temp
order by (case when id=@id or id=@aid then 1 ELSE case when Title<>'合计' then 2 else 3 end END) asc,ID asc

			SET ROWCOUNT @size
			SELECT 
				ID,Title,g1 [25岁及以下],g2 [26-30岁],g3 [31-35岁],g4 [36-40岁],g5 [41-45岁],g6 [46-50岁],g7 [51-55岁],g8 [56-60岁],g9 [61岁及以上] ,@pcount
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.ID=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select ID,Title,g1 [25岁及以下],g2 [26-30岁],g3 [31-35岁],g4 [36-40岁],g5 [41-45岁],g6 [46-50岁],g7 [51-55岁],g8 [56-60岁],g9 [61岁及以上] ,@pcount from #temp
	order by (case when id=@id or id=@aid then 1 ELSE case when Title<>'合计' then 2 else 3 end END) asc,ID asc
end

drop table #temptable

drop table #temp
drop table #tempareaid



GO
