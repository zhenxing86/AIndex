USE [edu_jn]
GO
/****** Object:  StoredProcedure [dbo].[BasicDataArea_GetListByAid]    Script Date: 2014/11/24 23:05:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[BasicDataArea_GetListByAid]
@gid int
,@aid int
,@level int
as


if(@level=-200)
begin


create table #temparea
(
lid int,
lsuperior int
)

--保证区域属于用户下的
insert into #temparea
select ID,-2 from Area 
where superior=@aid or ID=@aid


select distinct a.ID,Title,Superior,[level],Code,0 from #temparea t
inner join Area a on superior=t.lid or ID=t.lid

drop table #temparea

end
else
begin
select ID,Title,Superior,[level],Code,0 from Area 
where superior=@aid or ID=@aid
end


GO
