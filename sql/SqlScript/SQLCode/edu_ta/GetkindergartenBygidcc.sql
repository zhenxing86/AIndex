USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[GetkindergartenBygidcc]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[GetkindergartenBygidcc] 
@areaid int,
@uid int
as 


declare @uareaid int
select @uareaid=areaid from group_user where userid=@uid


create table #temp
(
lareaid int
)

insert into #temp(lareaid)
select ID from BasicData..Area 
where (superior=@uareaid or ID=@uareaid) and (ID=@areaid or @areaid=-1)


select kid,kname from gartenlist
inner join #temp on lareaid=areaid

drop table #temp



GO
