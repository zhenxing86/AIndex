USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[group_teachertrain_GetList]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[group_teachertrain_GetList]
@gid int
,@page int
,@size int

as 

declare @gkid int
select @gkid=kid from group_baseinfo where gid=@gid

create table #ulist
(
uid int
)


if(@gkid=0)
begin


insert into #ulist
select r.userid from dbo.group_baseinfo gi  
inner join BasicData..Area a on a.superior=gi.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
where gi.gid=@gid 
 

end
else
begin

insert into #ulist
select r.userid from dbo.group_baseinfo gi  
inner join group_partinfo a on a.g_kid=gi.kid
left join BasicData..kindergarten n on n.kid=a.p_kid 
inner join BasicData..[user] r on r.kid= n.kid and r.usertype=1
where gi.gid=@gid  
 
end

declare @pcount int

select @pcount=count(1) from #ulist

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
			select r.uid FROM #ulist r
left join BasicData..[user] u on u.userid=r.uid  
left join group_teachertrain g on  g.userid=r.uid  order by r.uid asc,[level] desc


			SET ROWCOUNT @size
			SELECT 
				@pcount,ID,r.uid,u.[name]
,timetype
,(select Caption from BasicData..Dict d where d.ID=timetype)
,[level]
,(select Caption from BasicData..Dict d where d.ID=[level])
			FROM 
				@tmptable AS tmptable		
			INNER JOIN #ulist r
			ON  tmptable.tmptableid=r.uid
left join BasicData..[user] u on u.userid=r.uid  
left join group_teachertrain g on  g.userid=r.uid  

	
			WHERE
				row>@ignore 

end
else
begin
SET ROWCOUNT @size

SELECT 
	@pcount,ID,r.uid,u.[name]
,timetype
,(select Caption from BasicData..Dict d where d.ID=timetype)
,[level]
,(select Caption from BasicData..Dict d where d.ID=[level])
FROM #ulist r
left join BasicData..[user] u on u.userid=r.uid  
left join group_teachertrain g on  g.userid=r.uid  order by r.uid asc,[level] desc

end
drop table #ulist

GO
