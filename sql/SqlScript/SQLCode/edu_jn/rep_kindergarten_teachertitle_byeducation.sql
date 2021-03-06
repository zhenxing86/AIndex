USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teachertitle_byeducation]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE PROCEDURE [dbo].[rep_kindergarten_teachertitle_byeducation]
@ty int
,@id int
,@aid int
,@page int
,@size int
as
create table #temp
(
kid varchar(50)
,kname varchar(50)
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
,yzg int
)

create table #temptable
(
kid varchar(50)
,kname varchar(50)
,education varchar(50)
,post varchar(50)
,teacher varchar(50)
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
select t.lareaid,t.lareatitle,t_education,t_post,
case when t_title like '%教师%' or t_title like '%老师%' then '专任教师' else 
case when t_title like '%园长%' then '园长' else '' end  end
from #tempareaid t
inner join Area a on (lareaid=ID or superior=lareaid)
inner join rep_kininfo r on a.ID=r.areaid
where (lareaid<>@ID or (lareaid=@ID and r.areaid=@ID) )
and r.usertype=1


end
else
begin


insert into #temptable
select a.lareaid,a.lareatitle,t_education,t_post,
case when t_title like '%教师%' or t_title like '%老师%' then '专任教师' else 
case when t_title like '%园长%' then '园长' else '' end  end
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
select r.kid,r.kname,t_education,t_post,
case when t_title like '%教师%' or t_title like '%老师%' then '专任教师' else 
case when t_title like '%园长%' then '园长' else '' end  end
from rep_kininfo r
inner join #tempareaid a on a.lareaid=r.areaid
where  r.usertype=1


end
------------------------------------------------------------------------------------------------------





insert into #temp
select kid,kname
,sum(case when education='研究生毕业'  then 1 else 0 end) 
,sum(case when education='本科毕业'   then 1 else 0 end)
,sum(case when education='专科毕业'  then 1 else 0 end) 
,sum(case when education='高中阶段'  then 1 else 0 end) 
,sum(case when education='高中阶段以下'  then 1 else 0 end) 
,sum(case when education='中专毕业' then 1 else 0 end) 
,sum(case when post='幼教高级' then 1 else 0 end) 
,sum(case when post='幼教一级' then 1 else 0 end) 
,sum(case when post='幼教二级' then 1 else 0 end) 
,sum(case when post='幼教三级' then 1 else 0 end) 
,sum(case when post='未定职级' then 1 else 0 end) 
,sum(case when post='幼中高' then 1 else 0 end) 
from #temptable group by kid,kname





--当市进来的时候，没有班级的街道补充进去
if(@lever=1 and (@aid=-1 or @id=@aid))
begin
insert into #temp
select ID,Title,0,0,0,0,0,0,0,0,0,0,0,0 from Area a
 where (@id=ID or superior=@id)
 and not exists(select 1 from #temp t where a.ID=t.kid)
end

if(@lever=2  and @aid=-1)
begin
insert into #temp
select ID,Title,0,0,0,0,0,0,0,0,0,0,0,0 from Area a
 where (@id=ID or superior=@id)
 and not exists(select 1 from #temp t where a.ID=t.kid)
end


insert into #temp
select count(kid),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7),sum(g8),sum(g9),sum(g10),sum(g11),sum(yzg) from #temp




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

			SET ROWCOUNT @size
			SELECT 
				@pcount,kid,kname,g1 研究生毕业,g2 本科毕业,g3 专科毕业,g4 高中阶段毕业,g5 高中阶段以下毕业,g6 中学高级,g7 幼教高级,g8 幼教一级,g9 幼教二级,g10 幼教三级,g11 未定职级,yzg 幼中高
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select @pcount,kid,kname,g1 研究生毕业,g2 本科毕业,g3 专科毕业,g4 高中阶段毕业,g5 高中阶段以下毕业,g6 中学高级,g7 幼教高级,g8 幼教一级,g9 幼教二级,g10 幼教三级,g11 未定职级,yzg 幼中高 from #temp
end





drop table #temptable

drop table #temp
drop table #tempareaid




GO
