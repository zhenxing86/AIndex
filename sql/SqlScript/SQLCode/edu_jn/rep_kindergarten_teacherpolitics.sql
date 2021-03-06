USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacherpolitics]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[rep_kindergarten_teacherpolitics] 
@ty int
,@id int
,@aid int
,@title varchar(50)
,@page int
,@size int
as
create table #temp
(
kid varchar(50)
,kname varchar(200)
,g1 int
,g2 int
,g3 int
,g4 int
,g5 int
,g6 int
)

create table #temptable
(
kid varchar(50)
,kname varchar(200)
,politicalface varchar(50)
,title varchar(50)
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





if(@lever=1 and @aid=-1 or @id=@aid)--统计市的时候需要将旗下一起计算
begin



insert into #temptable
select t.lareaid,t.lareatitle,t_politicalface,t_title
from #tempareaid t
inner join Area a on (lareaid=ID or superior=lareaid)
inner join rep_kininfo r on a.ID=r.areaid
--left join teacher x on x.userid=r.[uid]
where (lareaid<>@ID or (lareaid=@ID and r.areaid=@ID) )
and r.usertype=1


end
else
begin



insert into #temptable
select a.lareaid,a.lareatitle,t_politicalface,t_title
from #tempareaid a
inner join rep_kininfo r on a.lareaid=r.areaid
--left join teacher t on t.userid=r.[uid]
where  r.usertype=1

end

end


if(@aid>0)--当区域大于0的时候，表示已经选择了街道，于是显示幼儿园出来
begin

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@aid or ID=@aid)

insert into #temptable
select r.kid,r.kname,t_politicalface,t_title
from rep_kininfo r
inner join #tempareaid a on a.lareaid=r.areaid

where  r.usertype=1


end
------------------------------------------------------------------------------------------------------

insert into #temp(kid,kname,g1,g2,g3,g4,g6)
select kid,kname
,sum(case when politicalface='中共党员' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='共青团员' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='民主党派' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='华侨' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='群众' and title like @title+'%' then 1 else 0 end) 
 from #temptable group by kid,kname


update #temp set g5=g1+g2+g3+g4+g6






--当市进来的时候，没有班级的街道补充进去
if(@lever=1 and (@aid=-1 or @id=@aid))
begin
insert into #temp
select ID,Title,0,0,0,0,0,0 from Area a
 where (@id=ID or superior=@id)
 and not exists(select 1 from #temp t where a.ID=t.kid)
end

if(@lever=2  and @aid=-1)
begin
insert into #temp
select ID,Title,0,0,0,0,0,0 from Area a
 where (@id=ID or superior=@id)
 and not exists(select 1 from #temp t where a.ID=t.kid)
end



insert into #temp
select count(kname),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6) from #temp



declare @pcount int
select @pcount=count(kid) from #temp

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
			select kid from #temp
			order by (case when kid=@id or kid=@aid then 1 ELSE case when Title<>'合计' then 2 else 3 end END) asc,ID asc


			SET ROWCOUNT @size
			SELECT 
				@pcount,kid,kname,g1 共产党员,g2 共青团员,g3 民主党派,g4 华侨,g6 群众,g5 合计
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select @pcount,kid,kname,g1 共产党员,g2 共青团员,g3 民主党派,g4 华侨,g6 群众,g5 合计 from #temp
	order by (case when kid=@id or kid=@aid then 1 ELSE case when kname<>'合计' then 2 else 3 end END) asc,kid asc

end



drop table #temptable

drop table #temp

drop table #tempareaid


GO
