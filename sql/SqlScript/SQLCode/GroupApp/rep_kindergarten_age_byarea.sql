USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_age_byarea]    Script Date: 2014/11/24 23:09:23 ******/
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
,nation varchar(50)
,gender varchar(50)
,age varchar(50)
)
--托班,小班,中班,大班,学前班

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id



if(@gkid=0)
begin

if(@aid=-1)
begin

insert into #temptable
select a.ID,a.Title,birthday,nation,gender,0 from dbo.group_baseinfo gi
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID  
left join BasicData..[user] r on r.kid= n.kid and r.usertype=0 and r.deletetag=1
where gi.gid=@id and (a.ID=@aid or @aid=-1) 


end 
else
begin

insert into #temptable
select n.kid,n.kname,birthday,nation,gender,0 from dbo.group_baseinfo gi
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID  
left join BasicData..[user] r on r.kid= n.kid and r.usertype=0 and r.deletetag=1
where gi.gid=@id and (a.ID=@aid or @aid=-1) 


end


end
else
begin

insert into #temptable
select n.kid,n.kname,birthday,nation,gender,0 
from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join BasicData..[user] r on r.kid= n.kid and r.usertype=0 and r.deletetag=1
where gi.gid=@id 

end

update #temptable set age=dbo.FUN_GetAge(birthday)




insert into #temp(ID,Title,g1,g2,g3,g4,g5,g6,g7)
select ID,Title
,sum(case when age<3 then 1 else 0 end) [3岁以下]
,sum(case when age=3 then 1 else 0 end) [3岁]
,sum(case when age=4 then 1 else 0 end) [4岁]
,sum(case when age=5 then 1 else 0 end) [5岁]
,sum(case when age>=6 then 1 else 0 end) [6岁以上]
,sum(case when nation not in (6) then 1 else 0 end) [民族]
,sum(case when gender=2 then 1 else 0 end) [女]
 from #temptable group by ID,Title

insert into #temp
select count(Title),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5),sum(g6),sum(g7) from #temp

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

GO
