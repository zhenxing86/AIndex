USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[init_area]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[init_area]
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
