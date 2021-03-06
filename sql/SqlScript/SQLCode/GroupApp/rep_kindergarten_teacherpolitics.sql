USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_kindergarten_teacherpolitics]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_kindergarten_teacherpolitics]
@id int
,@aid int
,@title varchar(50)
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
)

create table #temptable
(
kid varchar(50)
,kname varchar(200)
,politicalface varchar(50)
,title varchar(50)
)
--托班,小班,中班,大班,学前班

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@id



if(@gkid=0)
begin


if(@aid=-1)
begin

insert into #temptable
select a.ID,a.Title,politicalface,t.title from group_baseinfo gi
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID  
inner join BasicData..[user] u on u.kid=n.kid and u.usertype=1
inner join BasicData..teacher t on t.userid=u.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1) 




end 
else
begin

insert into #temptable
select n.kid,n.[kname],politicalface,t.title from group_baseinfo gi
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID  
inner join BasicData..[user] u on u.kid=n.kid and u.usertype=1
inner join BasicData..teacher t on t.userid=u.userid 
where gi.gid=@id and (a.ID=@aid or @aid=-1) --group by [name],p_kid,gname,g.gid

end

end
else
begin

 insert into #temptable
select n.kid,n.[kname],politicalface,t.title from group_baseinfo gi
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
left join BasicData..[user] u on u.kid=n.kid and u.usertype=1
left join BasicData..teacher t on t.userid=u.userid 
where gi.gid=@id 





end


	

insert into #temp(kid,kname,g1,g2,g3,g4,g6)
select kid,kname
,sum(case when politicalface='中共党员' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='共青团员' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='民主党派' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='华侨' and title like @title+'%' then 1 else 0 end) 
,sum(case when politicalface='群众' and title like @title+'%' then 1 else 0 end) 
 from #temptable group by kid,kname


update #temp set g5=g1+g2+g3+g4+g6



--insert into #temp
--select count(kname),'合计',sum(g1),sum(g2),sum(g3),sum(g4),sum(g5) from #temp



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
				@pcount,kid,kname,g1 共产党员,g2 共青团员,g3 民主党派,g4 华侨,g6 群众,g5 合计
			FROM 
				@tmptable AS tmptable	
			inner join #temp n on n.kid=tmptableid
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size
	select @pcount,kid,kname,g1 共产党员,g2 共青团员,g3 民主党派,g4 华侨,g6 群众,g5 合计 from #temp
end

--select kid,kname,g1 共产党员,g2 共青团员,g3 民主党派,g4 华侨,g5 合计 from #temp

drop table #temptable

drop table #temp

GO
