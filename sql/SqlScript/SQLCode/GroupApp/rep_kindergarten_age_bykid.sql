USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_age_bykid]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[rep_kindergarten_age_bykid]
@ty int
,@id int
,@aid int
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
left join BasicData..[user] r on r.kid= n.kid and r.usertype=0
where gi.gid=@id and (a.ID=@aid or @aid=-1)

end
else
begin

insert into #temptable
select p_kid,p.[name],birthday,nation,gender,0 from dbo.group_partinfo p 
inner join BasicData..[user] r on r.kid=p.p_kid and r.usertype=0
where g_kid=@id and p.deletetag=1 

end



update #temptable set age=dbo.FUN_GetAge(birthday)



insert into #temp(kid,kname,g1,g2,g3,g4,g5,g6,g7)
select kid,kname
,sum(case when age<3 then 1 else 0 end) [3岁以下]
,sum(case when age=3 then 1 else 0 end) [3岁]
,sum(case when age=4 then 1 else 0 end) [4岁]
,sum(case when age=5 then 1 else 0 end) [5岁]
,sum(case when age>=6 then 1 else 0 end) [6岁以上]
,sum(case when nation not in (6) then 1 else 0 end) [民族]
,sum(case when gender=2 then 1 else 0 end) [女]
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
				@pcount,kid,kname,g1 [3岁以下],g2 [3岁],g3 [4岁],g4 [5岁],g5 [6岁及以上],g6 [民族],g7 [女]
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select @pcount,kid,kname,g1 [3岁以下],g2 [3岁],g3 [4岁],g4 [5岁],g5 [6岁及以上],g6 [民族],g7 [女] from #temp
end


drop table #temptable
drop table #temp

GO
