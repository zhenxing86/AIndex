USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetListByaids]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO













CREATE PROCEDURE [dbo].[MsgTeacher_GetListByaids]
@gid int
,@aid int--
,@kid int
,@title varchar(max)
,@uname varchar(100)
,@page int
,@size int
,@kname nvarchar(100)

as 



declare @udid int,@uareaid int,@udepid int

select @udid=did,@uareaid=areaid,@udepid=depid from dbo.group_user where userid=@kname



create table #temparea
(
lid int,
lsuperior int
)

--保证区域属于用户下的
insert into #temparea
select ID,-2 from Area 
where superior=@gid or ID=@gid

--将需要查询的区域列表查询出来
insert into #temparea
exec('select distinct a.ID,-1 from #temparea t
inner join Area a on superior=t.lid or ID=t.lid
where lsuperior=-2 and a.ID in ('+@title+')')
--删除多余的区域
delete #temparea where lsuperior=-2



declare @pcount int
declare @str varchar(max)
set @str=''

--select @str=@str+','+convert(varchar,userid) from 
--dbo.group_user 
--inner join #temparea on lid=areaid
--where  username like @uname+'%'

set @pcount=@@ROWCOUNT




--市管理员可看所有的
if(@udepid=1 and @udid=0)
begin


select  @pcount,(select title from Area where ID=@gid) areaname
,(select title from Area where ID=areaid) areaname,0 kid,'' [kname],userid,username,tel,
(select dname from dbo.group_department d where d.did=g.did) job,@str
 from   dbo.group_user g
inner join #temparea on lid=areaid
where  username like @uname+'%' 
order by areaid asc


end
--区县管理员可以看区县的
else if(@udepid>1 and @udid=0)
begin

select  @pcount,(select title from Area where ID=@gid) areaname
,(select title from Area where ID=areaid) areaname,0 kid,'' [kname],userid,username,tel,
(select dname from dbo.group_department d where d.did=g.did) job,@str
 from   dbo.group_user g
inner join #temparea on lid=areaid
where  username like @uname+'%' 
order by areaid asc


end
--市电教站或市托幼办的，只能看本单位的和区县隶属单位的
else if(@udepid=1 and @udid<0)
begin

select  @pcount,(select title from Area where ID=@gid) areaname
,(select title from Area where ID=areaid) areaname,0 kid,'' [kname],userid,username,tel,
(select dname from dbo.group_department d where d.did=g.did) job,@str
 from   dbo.group_user g
inner join #temparea on lid=areaid
where  username like @uname+'%' and did=@udid
order by areaid asc



end
--区县电教站或市托幼办的，只能看本单位的
else if(@udepid>1 and @udid<0)
begin


select  @pcount,(select title from Area where ID=@gid) areaname
,(select title from Area where ID=areaid) areaname,0 kid,'' [kname],userid,username,tel,
(select dname from dbo.group_department d where d.did=g.did) job,@str
 from   dbo.group_user g
inner join #temparea on lid=areaid
where  username like @uname+'%' and did=@udid
order by areaid asc

end


drop table #temparea



GO
