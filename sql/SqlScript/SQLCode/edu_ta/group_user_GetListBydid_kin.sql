USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[group_user_GetListBydid_kin]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[group_user_GetListBydid_kin]
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




--市管理员可看所有的

select userid,username,aname from dbo.group_user
inner join #temp on tareaid=areaid
where  did=@did
order by areaid asc




drop table #temp




GO
