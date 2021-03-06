USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_area]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[pro_init_area]
@areaid int
as

declare @level int
select @level=[level] from BasicData..Area where ID=@areaid
if(@level=1)
begin

----初始化区域
create table #temparea
(
lid int,
lsuperior int
)

insert into #temparea
select ID,-1 from BasicData..Area 
where superior=@areaid or ID=@areaid

insert into #temparea
select ID,Superior from BasicData..Area 
inner join #temparea on  superior=lid or ID=lid

delete #temparea where lsuperior=-1

delete Area

insert into Area

select distinct ID,Title,Superior,[level],Code,areanum from BasicData..Area
inner join #temparea on ID=lid




drop table #temparea
end
GO
