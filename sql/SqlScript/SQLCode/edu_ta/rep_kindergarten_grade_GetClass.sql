USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_grade_GetClass]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





--select * from BasicData..grade
--select * from BasicData..[class]

CREATE PROCEDURE [dbo].[rep_kindergarten_grade_GetClass]
@ty int--本身id
,@id int--188
,@aid int--737
,@status int--0
,@page int--1
,@size int--10
AS

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
,classcount int
,gname varchar(50)
,gid varchar(50)
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
select a.lareaid,a.lareatitle
,count(r.cid),r.gradename,r.gradeid
from #tempareaid a
inner join rep_classinfo r on a.lareaid=r.areaid
group by a.lareaid,a.lareatitle,gradename,r.gradeid

end


if(@aid>0)--当区域大于0的时候，表示已经选择了街道，于是显示幼儿园出来
begin


insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@aid or ID=@aid)

insert into #temptable
select r.kid,r.kname,count(r.cid),gradename,r.gradeid 
from rep_classinfo r
inner join #tempareaid a on a.lareaid=r.areaid
group by r.kid,r.kname,gradename,r.gradeid
end






insert into #temp
select kid,kname
,sum(case when gname='托班' then classcount else 0 end ) 托班
,sum(case when gname='小班' then classcount else 0 end ) 小班
,sum(case when gname='中班' then classcount else 0 end ) 中班
,sum(case when gname='大班' then classcount else 0 end ) 大班
,sum(case when gname='学前班' then classcount else 0 end ) 学前班
,sum(classcount) 总班级数
from #temptable where gname in ('托班','小班','中班','大班', '学前班' ) 
group by kid,kname


insert into #temp
select count(kname),'合计',sum(g1) 托班,sum(g2) 小班,sum(g3) 中班,sum(g4) 大班,sum(g5) 学前班,sum(g6) 总班级数 from #temp


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
				@pcount,kid,kname,g1 托班,g2 小班,g3 中班,g4 大班,g5 学前班,g6 总班级数
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select @pcount,kid,kname,g1 托班,g2 小班,g3 中班,g4 大班,g5 学前班,g6 总班级数 from #temp 
end




drop table #temptable
drop table #temp

drop table #tempareaid


--GO
--[rep_kindergarten_grade_GetClass] 188,188,-1,0,1,12
--GO
--[rep_kindergarten_grade_GetClass] 188,757,-1,0,1,12

GO
