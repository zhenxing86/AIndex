USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacherage_allkid]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teacherage_allkid]
@ty int
,@id int
,@aid int
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
,g7 int
,g8 int
,g9 int
)

create table #temptable
(
kid varchar(50)
,kname varchar(200)
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

insert into #temptable
select n.kid,kname,birthday,nation,gender,0 from dbo.group_baseinfo gi
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID  
left join BasicData..[user] r on r.kid= n.kid and r.usertype=1
where gi.gid=@id and (a.ID=@aid or @aid=-1)  

end
else
begin

insert into #temptable
select p_kid,p.[name],birthday,nation,gender,0 
from dbo.group_partinfo p 
inner join BasicData..[user] r on r.kid=p.p_kid and r.usertype=1
where g_kid=@id and p.deletetag=1

end


update #temptable set age=dbo.FUN_GetAge(birthday)



insert into #temp(kid,kname,g1,g2,g3,g4,g5,g6,g7,g8,g9)
select kid,kname
,sum(case when age=25 then 1 else 0 end) [25岁及以下]
,sum(case when age>25 and age<=30 then 1 else 0 end) [26-30岁]
,sum(case when age>30 and age<=35 then 1 else 0 end) [31-35岁]
,sum(case when age>35 and age<=40 then 1 else 0 end) [36-40岁]
,sum(case when age>40 and age<=45 then 1 else 0 end) [41-45岁]
,sum(case when age>45 and age<=50 then 1 else 0 end) [46-50岁]
,sum(case when age>50 and age<=55 then 1 else 0 end) [51-55岁]
,sum(case when age>55 and age<=60 then 1 else 0 end) [56-60岁]
,sum(case when age>=61 then 1 else 0 end) [61岁及以上]
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
				@pcount,kid,kname,g1 [25岁及以下],g2 [26-30岁],g3 [31-35岁],g4 [36-40岁],g5 [41-45岁],g6 [46-50岁],g7 [51-55岁],g8 [56-60岁],g9 [61岁及以上]
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select @pcount,kid,kname,g1 [25岁及以下],g2 [26-30岁],g3 [31-35岁],g4 [36-40岁],g5 [41-45岁],g6 [46-50岁],g7 [51-55岁],g8 [56-60岁],g9 [61岁及以上] from #temp
end



drop table #temptable

drop table #temp

GO
