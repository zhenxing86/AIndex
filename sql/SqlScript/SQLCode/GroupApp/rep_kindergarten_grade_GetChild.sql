USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_grade_GetChild]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from BasicData..user_class
CREATE PROCEDURE [dbo].[rep_kindergarten_grade_GetChild]
@ty int
,@id int
,@aid int
,@status int
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

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id

if(@gkid=0)
begin

if(@aid=-1)
begin

insert into #temptable
select a.ID,a.Title,count(u.userid),gname,g.gid from dbo.group_baseinfo gi
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID  
left join BasicData..[class] c on c.kid=n.kid and c.deletetag=1
left join BasicData..grade g on g.gid=c.grade 
left join BasicData..user_class u on u.cid=c.cid 
left join BasicData..[user] r on r.userid=u.userid and r.usertype=0
where gi.gid=@id and (a.ID=@aid or @aid=-1)   group by  a.ID,a.Title ,gname,g.gid

end 
else
begin

insert into #temptable
select n.kid,n.kname,count(u.userid),gname,g.gid from dbo.group_baseinfo gi
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID  
left join BasicData..[class] c on c.kid=n.kid and c.deletetag=1
left join BasicData..grade g on g.gid=c.grade 
left join BasicData..user_class u on u.cid=c.cid 
left join BasicData..[user] r on r.userid=u.userid and r.usertype=0
where gi.gid=@id and (a.ID=@aid or @aid=-1)   group by n.kname,n.kid ,gname,g.gid

end

end
else
begin

insert into #temptable
select n.kid,n.kname,count(u.userid),gname,g.gid
from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid
left join BasicData..[class] c on c.kid=n.kid and c.deletetag=1
left join BasicData..grade g on g.gid=c.grade 
left join BasicData..user_class u on u.cid=c.cid 
left join BasicData..[user] r on r.userid=u.userid and r.usertype=0
where gi.gid=@id and a.deletetag=1  group by n.kid,n.kname,gname,g.gid




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


if(@aid=-1)
begin
insert into #temp
select count(kname),'合计',sum(g1) 托班,sum(g2) 小班,sum(g3) 中班,sum(g4) 大班,sum(g5) 学前班,sum(g6) 总班级数 from #temp
end

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
				@pcount,kid,kname,g1 托班,g2 小班,g3 中班,g4 大班,g5 学前班,g6 总人数
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select @pcount,kid,kname,g1 托班,g2 小班,g3 中班,g4 大班,g5 学前班,g6 总人数 from #temp
end







drop table #temptable
drop table #temp



GO
