USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teachertitle_byeducation]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teachertitle_byeducation]
	@id int,
	@aid int,
	@page int,
	@size int
as
create table #temp
(kid varchar(50),kname varchar(50),g1 int,g2 int,g3 int,g4 int,g5 int,g6 int,g7 int,g8 int,g9 int,g10 int,g11 int,yzg int)

create table #temptable
(kid varchar(50),kname varchar(50),education varchar(50),post varchar(50),teacher varchar(50))
--托班,小班,中班,大班,学前班

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id

if(@gkid=0)
begin


if(@aid=-1)
begin

insert into #temptable
select  a.ID,a.Title,t.education,t.post,
case when t.title like '%教师%' or t.title like '%老师%' then '专任教师' else 
case when t.title like '%园长%' then '园长' else '' end  end
from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid =n.kid  and r.usertype in (1,97)
inner join BasicData..teacher t on t.userid=r.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end 
else
begin

insert into #temptable
select n.kid,n.kname,t.education,t.post,
case when t.title like '%教师%' or t.title like '%老师%' then '专任教师' else 
case when t.title like '%园长%' then '园长' else '' end  end
from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid =n.kid  and r.usertype in (1,97)
inner join BasicData..teacher t on t.userid=r.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end

end
else
begin


insert into #temptable
select n.kid,n.kname,t.education,t.post,
case when t.title like '%教师%' or t.title like '%老师%' then '专任教师' else 
case when t.title like '%园长%' then '园长' else '' end  end
from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join BasicData..[user] r on r.kid =n.kid  and r.usertype in (1,97)
left join BasicData..teacher t on t.userid=r.userid 
where gi.gid=@id 
 
end

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
				@pcount,kid,kname,g1 研究生毕业,g2 本科毕业,g3 专科毕业,g4 高中阶段毕业,g5 高中阶段以下毕业,
				g6 中学高级,g7 幼教高级,g8 幼教一级,g9 幼教二级,g10 幼教三级,g11 未定职级,yzg 幼中高
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select	@pcount,kid,kname,g1 研究生毕业,g2 本科毕业,g3 专科毕业,g4 高中阶段毕业,
					g5 高中阶段以下毕业,g6 中学高级,g7 幼教高级,g8 幼教一级,g9 幼教二级,g10 幼教三级,g11 未定职级,yzg 幼中高 
		from #temp
end

drop table #temptable

drop table #temp

GO
