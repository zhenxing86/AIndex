USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[init_rep_growthbook]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_rep_growthbook] 
@kid int--全部：-1
AS



create table #temp
(
gbid int
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
tgbid int
,userid int
,tlcount int
,twcount int 
,tvcount int 
)


if(@kid=-1)
begin


delete rep_growthbook


insert into dbo.rep_growthbook(gbid,kid,cid,[uid],term,cname,uname)
select  gbid,c.kid,uc.cid,gb.userid,term,c.cname,u.name from GBapp..GrowthBook gb
inner join BasicData..user_class uc  on gb.userid=uc.userid
inner join BasicData..class c on c.cid =uc.cid
inner join BasicData..[user] u on u.userid=gb.userid

insert into #tempCount(tgbid,tlcount)
select t.gbid,COUNT(distinct l.photoid) from rep_growthbook t
inner join GBapp..gblifephoto l on t.gbid=l.gbid
group by t.gbid



update rep_growthbook set lifecount=tlcount
from #tempCount where tgbid=gbid
delete #tempCount

insert into #tempCount(tgbid,twcount)
select t.gbid,COUNT(distinct w.photoid) from rep_growthbook t
inner join GBapp..gbworkphoto w on t.gbid=w.gbid
group by t.gbid

update rep_growthbook set workcount=twcount
from #tempCount where tgbid=gbid
delete #tempCount

insert into #tempCount(tgbid,tvcount)
select t.gbid,COUNT(distinct l.videoid) from rep_growthbook t
inner join GBapp..gbvideo l on t.gbid=l.gbid
group by t.gbid

update rep_growthbook set videocount=tvcount
from #tempCount where tgbid=gbid

end
else
begin

delete rep_growthbook where kid=@kid

insert into #temp(gbid,kid,cid,cname,userid,term)
select  gbid,c.kid,uc.cid,cname,gb.userid,term from GBapp..GrowthBook gb
inner join BasicData..user_class uc  on gb.userid=uc.userid
inner join BasicData..class c on c.cid =uc.cid
where  kid=@kid


insert into #tempCount(tgbid,tlcount)
select t.gbid,COUNT(distinct l.photoid) from #temp t
inner join GBapp..gblifephoto l on t.gbid=l.gbid
group by t.gbid


update #temp set lcount=tlcount
from #tempCount where tgbid=gbid
delete #tempCount

insert into #tempCount(tgbid,twcount)
select t.gbid,COUNT(distinct w.photoid) from #temp t
inner join GBapp..gbworkphoto w on t.gbid=w.gbid
group by t.gbid

update #temp set wcount=twcount
from #tempCount where tgbid=gbid
delete #tempCount


insert into #tempCount(tgbid,tvcount)
select t.gbid,COUNT(distinct l.videoid) from #temp t
inner join GBapp..gbvideo l on t.gbid=l.gbid
group by t.gbid

update #temp set vcount=tvcount
from #tempCount where tgbid=gbid

delete rep_growthbook where kid=@kid

insert into dbo.rep_growthbook(gbid,kid,cid,[uid],term,lifecount,workcount,videocount,uname,cname)
select t.gbid,t.kid,cid,t.userid,term,lcount,wcount,vcount,u.name,cname 
from #temp t 
left join BasicData..[user] u on u.userid=t.userid 

end

drop table #tempCount
drop table #temp

GO
