USE [GroupApp]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetListByUid]    Script Date: 2014/11/24 23:09:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- [MsgTeacher_GetListByUid] 0 , 1 ,10
CREATE PROCEDURE [dbo].[MsgTeacher_GetListByUid]
@useridstr varchar(max)
,@page int
,@size int
as 


set @useridstr='0'+@useridstr

declare @pcount int

select @pcount = count(1) from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
left join BasicData..teacher t on t.userid=r.userid
where   @useridstr like '%'+convert(varchar,r.userid)+'%'






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
insert into #temp
exec('select '+@pcount+',(select title from BasicData..Area ar where ar.id=area)
,a.Title,n.kid,n.[kname],r.userid,r.[name],r.mobile,t.title job from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
left join BasicData..teacher t on t.userid=r.userid
where r.userid in ('+@useridstr +')')


			SET ROWCOUNT @prep
			INSERT INTO @tmptable(tmptableid)
			select userid from #temp

			SET ROWCOUNT @size
			SELECT 
				pcount,area,title,kid,kname,userid,uname,mobile,job
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

exec('select '+@pcount+',(select title from BasicData..Area ar where ar.id=area)
,a.Title,n.kid,n.[kname],r.userid,r.[name],r.mobile,t.title job from dbo.group_baseinfo g 
inner join BasicData..Area a on a.superior=g.areaid
left join BasicData..kindergarten n on n.residence=a.ID 
inner join BasicData..[user] r on r.kid= n.kid and usertype=1
left join BasicData..teacher t on t.userid=r.userid
where r.userid in ('+@useridstr +')')

end

GO
