USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teachertrainByTime]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE PROCEDURE [dbo].[rep_kindergarten_teachertrainByTime]
@ty int
,@gid int
,@aid int
,@timetype int
,@page int
,@size int
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
,g7 int
,g8 int
,g9 int
,g10 int
)

create table #temptable
(
kid varchar(50)
,kname varchar(200)
,timetype varchar(50)
,[level] varchar(50)
)


------------------------------------------------------------------------------------------------------
create table #tempareaid
(
lareaid int,
lareatitle nvarchar(100)
)

declare @lever int,@clever int
select @lever=[level] from Area where ID=@gid
select @clever=[level] from Area where ID=@aid


if(@lever=1 or (@lever=2 and @aid=-1))--省市进来的时候显示旗下区县，区县进来@aid=-1的时候，显示街道
begin



insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@gid or ID=@gid)


if(@lever=1 and @aid=-1 or @gid=@aid)--统计市的时候需要将旗下一起计算
begin

insert into #temptable
select t.lareaid,t.lareatitle,c.timetype,c.[level]
from #tempareaid t
inner join Area a on (lareaid=ID or superior=lareaid)
inner join rep_kininfo r on a.ID=r.areaid
left join kininfoapp..group_teachertrain c on c.userid=r.[uid]
where (lareaid<>@gid or (lareaid=@gid and r.areaid=@gid) )
and r.usertype=1 and (@timetype=-1 or c.timetype=@timetype)


end
else
begin


insert into #temptable
select a.lareaid,a.lareatitle,c.timetype,c.[level]
from #tempareaid a
inner join rep_kininfo r on a.lareaid=r.areaid
left join kininfoapp..group_teachertrain c on c.userid=r.[uid]
where  r.usertype=1 and (@timetype=-1 or c.timetype=@timetype)

end

end


if(@aid>0)--当区域大于0的时候，表示已经选择了街道，于是显示幼儿园出来
begin

insert into #tempareaid(lareaid,lareatitle)
select ID,Title from Area 
where (superior=@aid or ID=@aid)

insert into #temptable
select r.kid,r.kname,c.timetype,c.[level]
from rep_kininfo r
inner join #tempareaid a on a.lareaid=r.areaid
left join kininfoapp..group_teachertrain c on c.userid=r.[uid]
where  r.usertype=1 and (@timetype=-1 or c.timetype=@timetype)


end
------------------------------------------------------------------------------------------------------



insert into #temp(kid,kname,g5,g1,g2,g3,g4,g6,g7,g8,g9,g10)
select kid,kname
,sum(1) 总人数
,sum(case when [level] =11 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 园内培训
,sum(case when [level] =12 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) [区/县培训]
,sum(case when [level] =13 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 市级培训
,sum(case when [level] =14 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 省级培训
,sum(case when [level] =15 and (timetype=@timetype or @timetype=-1) then 1 else 0 end) 国家级培训
,kid kidp,@aid areaid,@clever [level],max(timetype)
 from #temptable group by kid,kname


update #temp set g5=g1+g2+g3+g4+g6+g7+g8+g9+g10



--当市进来的时候，没有班级的街道补充进去
if(@lever=1 and (@aid=-1 or @gid=@aid))
begin
insert into #temp
select ID,Title,0,0,0,0,0,0,0,0,0,0 from Area a
 where (@gid=ID or superior=@gid)
 and not exists(select 1 from #temp t where a.ID=t.kid)
end

if(@lever=2  and @aid=-1)
begin
insert into #temp
select ID,Title,0,0,0,0,0,0,0,0,0,0 from Area a
 where (@gid=ID or superior=@gid)
 and not exists(select 1 from #temp t where a.ID=t.kid)
end


insert into #temp
select count(kname),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7),sum(g8),sum(g9),sum(g10) from #temp


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
order by (case when kid=@gid or kid=@aid then 1 ELSE case when kname<>'合计' then 2 else 3 end END) asc,kid asc

			SET ROWCOUNT @size
				
select @pcount,kid,kname,g5,g1,g2,g3,g4,g6,g7,g8,g9,g10 

			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	
select @pcount,kid,kname,g5,g1,g2,g3,g4,g6,g7,g8,g9,g10  from #temp
order by (case when kid=@gid or kid=@aid then 1 ELSE case when kname<>'合计' then 2 else 3 end END) asc,kid asc

end










drop table #temptable

drop table #temp

drop table #tempareaid




GO
