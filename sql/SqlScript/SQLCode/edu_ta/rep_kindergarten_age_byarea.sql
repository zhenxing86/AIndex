USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_age_byarea]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[rep_kindergarten_age_byarea]
@ty int
,@id int
,@aid int
,@page int
,@size int
AS


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
)

create table #temptable
(
ID varchar(50)
,Title varchar(200)
,birthday datetime
,nation varchar(100)
,gender varchar(50)
,age varchar(50)
)
--托班,小班,中班,大班,学前班




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


insert into #temptable
select a.lareaid,a.lareatitle,birthday,nation,gender,0
from #tempareaid a
left join rep_kininfo r on a.lareaid=r.areaid
where  r.usertype=0



end


if(@aid>0)--当区域大于0的时候，表示已经选择了街道，于是显示幼儿园出来
begin

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@aid or ID=@aid)

insert into #temptable
select r.kid,r.kname,birthday,nation,gender,0
from #tempareaid a 
left join rep_kininfo r on a.lareaid=r.areaid
where  r.usertype=0


end



update #temptable set age=dbo.FUN_GetAge(birthday)




insert into #temp(ID,Title,g1,g2,g3,g4,g5,g6,g7)
select ID,Title
,sum(case when age<3 then 1 else 0 end) [3岁以下]
,sum(case when age=3 then 1 else 0 end) [3岁]
,sum(case when age=4 then 1 else 0 end) [4岁]
,sum(case when age=5 then 1 else 0 end) [5岁]
,sum(case when age>=6 then 1 else 0 end) [6岁以上]
,sum(case when nation <>6 then 1 else 0 end) [民族]
,sum(case when gender=2 then 1 else 0 end) [女]
 from #temptable group by ID,Title

insert into #temp
select g.kid,g.kname,0,0,0,0,0,0,0
 from dbo.gartenlist g
inner join #tempareaid on lareaid=areaid
where not exists (select 1 from #temp t where t.ID =g.kid) and @aid>0


--if(@aid=-1)
--begin
insert into #temp
select count(Title),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7) from #temp
--end

--select ID,Title,g1 [3岁以下],g2 [3岁],g3 [4岁],g4 [5岁],g5 [6岁及以上],g6 [民族],g7 [女] from #temp


declare @pcount int
select @pcount=count(Title) from #temp

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
			select Title from #temp

			SET ROWCOUNT @size
			SELECT 
				ID,Title,g1 [3岁以下],g2 [3岁],g3 [4岁],g4 [5岁],g5 [6岁及以上],g6 [民族],g7 [女] ,@pcount
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.Title=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select ID,Title,g1 [3岁以下],g2 [3岁],g3 [4岁],g4 [5岁],g5 [6岁及以上],g6 [民族],g7 [女] ,@pcount from #temp
end


drop table #temptable
drop table #temp
drop table #tempareaid


GO
