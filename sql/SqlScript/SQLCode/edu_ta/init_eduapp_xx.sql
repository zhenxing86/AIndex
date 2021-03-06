USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[init_eduapp_xx]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[init_eduapp_xx]
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

--delete Area
--
--insert into Area
--select distinct ID,Title,Superior,[level],Code,areanum from BasicData..Area
--inner join #temparea on ID=lid
--drop table #temparea
----初始化区域



----初始化幼儿园
--delete gartenlist
--
--insert into gartenlist(kid,kname,sitedns,mingyuan,orderby,areaid)
--select k.kid,k.kname,s.sitedns,'',0,[dbo].[GetKinArea](k.privince,k.city,k.area,k.residence) from BasicData..kindergarten k
--left join kwebcms..site s on s.siteid=kid and area=@areaid

----初始化幼儿园


exec dbo.IndexTo10PhotoSyn

exec dbo.BlogPostsSyn

exec dbo.gartenPhotoSyn

exec dbo.init_rep_classinfo

exec dbo.init_rep_kininfo

end
else
begin

select '区域ID不符合，你需要输入一个市的区域ID'
end




GO
