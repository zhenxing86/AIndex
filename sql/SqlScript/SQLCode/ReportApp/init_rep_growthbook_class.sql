USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_growthbook_class]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_rep_growthbook_class]
@kid int--全部：-1
AS

create table #temp
(
hbid int
,kid int
,cid int
,cname nvarchar(30)
,userid int
,term varchar(20)
,lcount int
,wcount int 
,vcount int 
)

create table #tempCount
(
thbid int
,userid int
,tlcount int
,twcount int 
,tvcount int 
)


insert into #temp(hbid,kid,cid,cname,term)
select hbid,c.kid,c.cid,cname,term from BasicData..class c
left join GBapp..HomeBook h on c.cid =h.classid
where  h.kid=@kid and c.deletetag=1

delete #tempCount
insert into #tempCount(thbid,tlcount)
select h.hbid,count(distinct m_path)  from #temp h
inner join GBApp..GrowthBook g on g.hbid=h.hbid
inner join GBApp..gblifephoto l on l.gbid=g.gbid
where h.kid=@kid and l.deletetag=1
group by h.hbid



update #temp set lcount=tlcount
from #tempCount where thbid=hbid
delete #tempCount


delete #tempCount
insert into #tempCount(thbid,twcount)
select h.hbid,COUNT(distinct w.m_path) from #temp h
inner join GBApp..GrowthBook g on g.hbid=h.hbid
inner join GBapp..gbworkphoto w on g.gbid=w.gbid
where h.kid=@kid and w.deletetag=1
group by h.hbid

update #temp set wcount=twcount
from #tempCount where thbid=hbid
delete #tempCount



delete #tempCount
insert into #tempCount(thbid,tvcount)
select h.hbid,COUNT(distinct l.[path]) from #temp h
inner join GBApp..GrowthBook g on g.hbid=h.hbid
inner join GBapp..gbvideo l on g.gbid=l.gbid
where h.kid=@kid
group by h.hbid

update #temp set vcount=tvcount
from #tempCount where thbid=hbid

delete rep_growthbook_class where kid=@kid

insert into dbo.rep_growthbook_class(gbid,kid,cid,term,lifecount,workcount,videocount,cname)
select t.hbid,kid,cid,term,lcount,wcount,vcount,cname from #temp t 

/*
--select classid,count(distinct m_path)  from GBApp..HomeBook h
--inner join GBApp..GrowthBook g on g.hbid=h.hbid
--inner join GBApp..gblifephoto l on l.gbid=g.gbid
--where h.kid=@kid 
--group by classid
*/


drop table #tempCount
drop table #temp



GO
