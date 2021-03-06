USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetList]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MsgTeacher_GetList]
@gid int
,@aid int--当@aid=-2表示集团进来，使用kid来查询
,@kid int
,@title varchar(100)
,@uname varchar(100)
,@page int
,@size int
as 

declare @pcount int
declare @str varchar(max)
set @str=''

if(@aid=-2)
begin
select @str=@str+','+convert(varchar,r.userid) 
from   BasicData..[user] r
left join BasicData..teacher t on t.userid=r.userid and r.usertype=1
where (r.kID=@kid or @kid=-1) 
and t.title like @title+'%' and r.[name] like '%'+@uname+'%'

end
else
begin
select @str=@str+','+convert(varchar,r.userid) from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
left join BasicData..teacher t on t.userid=r.userid
where g.gid=@gid and (a.ID=@aid or @aid=-1) and (r.kID=@kid or @kid=-1) 
and t.title like @title+'%' and r.[name] like '%'+@uname+'%'

end

set @pcount=@@ROWCOUNT
IF(@page>1)
	BEGIN
	
create table #temp
(
pcount int
,area varchar(100)
,title varchar(100)
,kid int
,kname varchar(100)
,userid int
,uname varchar(100)
,mobile varchar(100)
,job varchar(100)
)
		DECLARE @prep int,@ignore int

		SET @prep=@size*@page
		SET @ignore=@prep-@size

		DECLARE @tmptable TABLE
		(
			row int IDENTITY(1,1),
			tmptableid bigint
		)

SET ROWCOUNT @prep

if(@aid=-2)
begin

insert into #temp
select @pcount,(select title from BasicData..Area ar where ar.id=r.residence)
,(select title from BasicData..Area ar where ar.id=n.residence),n.kid,n.[kname],r.userid,r.[name],r.mobile,t.title job 
from  BasicData..kindergarten n 
inner join BasicData..[user] r on r.kid= n.kid
left join BasicData..teacher t on t.userid=r.userid and r.usertype=1
where (r.kID=@kid or @kid=-1) 
and t.title like @title+'%' and r.[name] like '%'+@uname+'%'
end
else
begin
insert into #temp
select @pcount,(select title from BasicData..Area ar where ar.id=area)
,a.Title,n.kid,n.[kname],r.userid,r.[name],r.mobile,t.title job from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
left join BasicData..teacher t on t.userid=r.userid
where g.gid=@gid and (a.ID=@aid or @aid=-1) and (r.kID=@kid or @kid=-1) 
and t.title like @title+'%' and r.[name] like '%'+@uname+'%'

end
			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			select userid from #temp

			SET ROWCOUNT @size
			SELECT 
				pcount,area,title,kid,kname,userid,uname,mobile,job,@str
			FROM 
				@tmptable AS tmptable	
		inner join #temp on tmptableid=userid

			WHERE
				row>@ignore 

drop table #temp
end
else
begin
SET ROWCOUNT @size

if(@aid=-2)
begin

select @pcount,(select title from BasicData..Area ar where ar.id=r.residence)
,(select title from BasicData..Area ar where ar.id=n.residence),n.kid,n.[kname],r.userid,r.[name],r.mobile,t.title job,@str 
from   BasicData..kindergarten n 
inner join BasicData..[user] r on r.kid= n.kid 
left join BasicData..teacher t on t.userid=r.userid and usertype=1
where (r.kID=@kid or @kid=-1) 
and t.title like @title+'%' and r.[name] like '%'+@uname+'%'
end
else
begin

select @pcount,(select title from BasicData..Area ar where ar.id=area)
,a.Title,n.kid,n.[kname],r.userid,r.[name],r.mobile,t.title job,@str from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
left join BasicData..teacher t on t.userid=r.userid
where g.gid=@gid and (a.ID=@aid or @aid=-1) and (r.kID=@kid or @kid=-1) 
and t.title like @title+'%' and r.[name] like '%'+@uname+'%'

end

end

GO
