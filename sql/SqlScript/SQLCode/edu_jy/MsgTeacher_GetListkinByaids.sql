USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[MsgTeacher_GetListkinByaids]    Script Date: 07/30/2013 14:41:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[MsgTeacher_GetListkinByaids]
@gid int
,@aid int--
,@kid int
,@title varchar(100)
,@uname varchar(100)
,@page int
,@size int
,@kname nvarchar(100)
,@byxz nvarchar(100)
as 

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

--select @str=@str+','+convert(varchar,uid) from 
--dbo.rep_kininfo 
--inner join #temparea on lid=areaid
--where uname like @uname+'%'
--and kname like @kname+'%'

set @pcount=@@ROWCOUNT
if(@gid=722)
begin

select @pcount,(select title from Area where ID=u_privince) areaname
,areaname,r.kid,r.[kname],[uid],uname,u_mobile,t_title,@str
 from  rep_kininfo r 
inner join #temparea on lid=areaid
inner join gartenlist g on g.kid=r.kid
where  t_title in  ('园长','业务园长','管理员') and uname like @uname+'%'
 and r.kname like @kname+'%' and (byxz = @byxz or @byxz='')
order by r.areaid asc

end
else
begin

select @pcount,(select title from Area where ID=u_privince) areaname
,areaname,r.kid,r.[kname],[uid],uname,u_mobile,t_title,@str
 from  rep_kininfo r 
inner join #temparea on lid=areaid
inner join gartenlist g on g.kid=r.kid
where  t_title like '园长%' and uname like @uname+'%'
 and r.kname like @kname+'%' and (byxz = @byxz or @byxz='')
order by r.areaid asc
end

drop table #temparea


GO
MsgTeacher_GetListkinByaids 722,-1,-300,'-1,722,1256,1257,1258,1259,1260,1261,1262,1263,1264','', 1,12,'',''


