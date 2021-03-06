USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacherpost_bytitle]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[rep_kindergarten_teacherpost_bytitle]
@ty int
,@id int
,@aid int
,@page int
,@size int
as
create table #temp
(
kid varchar(50)
,title varchar(50)
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
kid varchar(50)
,kname varchar(50)
,birthday datetime
,title varchar(50)
,employmentform varchar(50)
,gender int
,nation varchar(50)
,age int
,kinschooltag int
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


insert into #temptable
select a.lareaid,a.lareatitle,birthday,t_title,t_employmentform,gender,nation,0,t_kinschooltag
from #tempareaid a
inner join rep_kininfo r on a.lareaid=r.areaid
where  r.usertype=1


end


if(@aid>0)--当区域大于0的时候，表示已经选择了街道，于是显示幼儿园出来
begin

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@aid or ID=@aid)

insert into #temptable
select r.kid,r.kname,birthday,t_title,t_employmentform,gender,nation,0,t_kinschooltag
from rep_kininfo r
inner join #tempareaid a on a.lareaid=r.areaid
where  r.usertype=1


end
------------------------------------------------------------------------------------------------------



insert into #temp
select kid,kname
,sum(case when title='园长' then 1 else 0 end)  
,sum(case when (title like '%教师%' or title like '%老师%') then 1 else 0 end)
,sum(case when title='保健医生'  then 1 else 0 end) 
,sum(case when title='保育员'  then 1 else 0 end) 
,sum(case when (title='其他' or title='')  then 1 else 0 end) 
,sum(case when employmentform='代课教师'  then 1 else 0 end) 
,sum(case when employmentform='兼任教师'  then 1 else 0 end) 
,sum(case when kinschooltag=1  then 1 else 0 end) 
,sum(case when gender=2  then 1 else 0 end) 
from #temptable group by kid,kname


insert into #temp
select g.kid,g.kname,0,0,0,0,0,0,0,0,0
 from dbo.gartenlist g
inner join #tempareaid on lareaid=areaid
where not exists (select 1 from #temp t where t.kid =g.kid) and @aid>0


insert into #temp
select count(kid),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7),sum(g8),sum(g9) from #temp

declare @pcount int
select @pcount=count(kid) from #temp

--
--declare @pcount int
--select @pcount=count(kid) from #temp
--
--IF(@page>1)
--	BEGIN
--	
--		DECLARE @prep int,@ignore int
--
--		SET @prep=@size*@page
--		SET @ignore=@prep-@size
--
--		DECLARE @tmptable TABLE
--		(
--			row int IDENTITY(1,1),
--			tmptableid bigint
--		)
--
--			SET ROWCOUNT @prep
--			INSERT INTO @tmptable(tmptableid)
--			select kid from #temp
--
--			SET ROWCOUNT @size
--			SELECT 
--				@pcount,kid,title,g1 园长,g2 专任教师,g3 保健医,g4 保育员,g5 其他,g6 代课教师,g7 兼任教师,g8 幼儿师范毕业,g9 女,(g1+g2+g3+g4+g5+g6+g7+g8+g9) 合计
--			FROM 
--				@tmptable AS tmptable	
--			inner join #temp n on n.kid=tmptableid
--			WHERE
--				row>@ignore 
--
--end
--else
--begin
--SET ROWCOUNT @size

	select @pcount,kid,title,g1 园长,g2 专任教师,g3 保健医,g4 保育员,g5 其他,g6 代课教师,g7 兼任教师,g8 幼儿师范毕业,g9 女 
,(g1+g2+g3+g4+g5+g6+g7+g8+g9) 合计
from #temp 
--end




drop table #temptable

drop table #temp

drop table #tempareaid

GO
