USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacherpost_bytitle]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teacherpost_bytitle]
@id int
,@aid int
,@page int
,@size int
as
create table #temp
(kid varchar(50),title varchar(50),g1 int,g2 int,g3 int,g4 int,g5 int,g6 int,g7 int,g8 int,g9 int)

create table #temptable
(kid varchar(50),kname varchar(50),birthday datetime,title varchar(50),employmentform varchar(50),gender int,nation int,age int,kinschooltag int)
--托班,小班,中班,大班,学前班

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id

if(@gkid=0)
begin


if(@aid=-1)
begin

insert into #temptable
select a.ID,a.Title,birthday,
t.title,employmentform,gender,nation,0,kinschooltag
from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid =n.kid and r.usertype in (1,97)
inner join BasicData..teacher t on t.userid=r.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end 
else
begin

insert into #temptable
select n.kid,n.kname,birthday,
t.title,employmentform,gender,nation,0,kinschooltag
from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid =n.kid and r.usertype in (1,97)
inner join BasicData..teacher t on t.userid=r.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end

end
else
begin

insert into #temptable
select n.kid,n.kname,birthday,
t.title,employmentform,gender,nation,0,kinschooltag
from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join BasicData..[user] r on r.kid=n.kid and r.usertype in (1,97)
left join BasicData..teacher t on t.userid=r.userid 
where gi.gid=@id 
end

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
				@pcount,kid,title,g1 园长,g2 专任教师,g3 保健医,g4 保育员,g5 其他,g6 代课教师,g7 兼任教师,g8 幼儿师范毕业,g9 女,(g1+g2+g3+g4+g5+g6+g7+g8+g9) 合计
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

	select @pcount,kid,title,g1 园长,g2 专任教师,g3 保健医,g4 保育员,g5 其他,g6 代课教师,g7 兼任教师,g8 幼儿师范毕业,g9 女 
,(g1+g2+g3+g4+g5+g6+g7+g8+g9) 合计
from #temp 
end




drop table #temptable

drop table #temp

GO
