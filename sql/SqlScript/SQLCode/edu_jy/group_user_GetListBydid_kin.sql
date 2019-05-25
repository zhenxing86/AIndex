USE [edu_jy]
GO
/****** Object:  StoredProcedure [dbo].[group_user_GetListBydid_kin]    Script Date: 07/27/2013 17:54:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





ALTER PROCEDURE [dbo].[group_user_GetListBydid_kin]
@did int
,@aid varchar(max)
,@uaid int
as 

declare @udid int,@uareaid int,@udepid int

set @udid=0
set @uareaid=@uaid
set @udepid=1



create table #temp
(
tareaid int
,lsuperior int
,aname nvarchar(100)
)


--保证区域属于用户下的
insert into #temp
select ID,-2,title from Area 
where superior=@uareaid or ID=@uareaid



--将需要查询的区域列表查询出来
insert into #temp
exec('select distinct a.ID,-1,title from #temp t
inner join Area a on superior=t.tareaid or ID=t.tareaid
where lsuperior=-2 and a.ID in ('+@aid+')')
--删除多余的区域
delete #temp where lsuperior=-2


if(@uaid=722)
begin

insert into #temp
select ID,-1,title from Area
where superior=722


select userid,username,aname from dbo.group_user
inner join #temp on tareaid=areaid
where  did=@did and deletetag=1
order by areaid asc


end
else
begin

--市管理员可看所有的

select userid,username,aname from dbo.group_user
inner join #temp on tareaid=areaid
where  did=@did and deletetag=1
order by areaid asc

end


drop table #temp

GO

[group_user_GetListBydid_kin] -2,'-1,722,1256,1257,1258,1259,1260,1261,1262,1263,1264',722