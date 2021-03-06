USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[init_Ebook_do]    Script Date: 06/15/2013 15:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_Ebook_do]

as

create table #ulist
(
	oid int,
	nid int,
	xid int,
	oterm varchar(30)
) 

create table #plist
(
	poid int,
	pnid int,
	pxid int,
	pterm varchar(30)
) 

delete ebook..hb_homebook where classid in (select ncid from BasicData..init_Baseinfo)



insert into ebook..hb_homebook
select (select top 1 ncid from BasicData..init_Baseinfo where cid=classid)  ncid,[classname],[grade],[term],0 [hbtermmessageid],[createdate],[childlist],[albums],[deletetag]+10,[booktype],[celltype],[sectiontype],[msgcontent],[classnotice],[classphoto],[classteacher],[theme]
 from ebook..hb_homebook h where classid in (select distinct cid from BasicData..init_Baseinfo) 


insert into #ulist(oid,nid,oterm)
select homebookid,ncid,term  from ebook..hb_homebook h
inner join BasicData..init_Baseinfo i on i.cid=h.classid

update #ulist set xid=homebookid from ebook..hb_homebook where [deletetag]>5 and nid=classid and oterm=term
--oid=旧的homebookid，nid-新的cid，xid=新的homebookid

update ebook..hb_homebook set [deletetag]=[deletetag]-10 where [deletetag]>5


--gb_growthbook
delete ebook..gb_growthbook where homebookid in (select xid from #ulist )

--测试到这里插入
insert into ebook..gb_growthbook
select nuid,[classname],[grade],[term],[createdate],0,[albums],[albums1],[bookver]+10,(select top 1 xid from #ulist where oid=[homebookid] and oterm=term and nid=ncid) nhid,[albums2],[booktype],[theme]
 from ebook..gb_growthbook g
inner join BasicData..init_Baseinfo  i on i.uid=g.userid 

insert into #plist(poid,pnid,pterm)
select growthbookid,nuid,term  from ebook..gb_growthbook h
inner join BasicData..init_Baseinfo i on i.uid=h.userid

update #plist set pxid=growthbookid from ebook..gb_growthbook where [bookver]>5 and pnid=userid and pterm=term
--poid=旧的growthbookid，pnid-新的userid，pxid=新的growthbookid

--gb_termremark
delete ebook..gb_termremark where userid in (select pnid from #plist)

insert into ebook..gb_termremark
select nuid,(select pxid from #plist where poid=growthbookid),(select top 1 xid from #ulist where oid=homebookid),[remarkcontent] from BasicData..init_Baseinfo 
inner join ebook..gb_termremark on uid=userid

--ebook..gb_weekremark
delete ebook..gb_weekremark where userid in (select pnid from #plist)

insert into ebook..gb_weekremark
select (select top 1 xid from #ulist where oid=homebookid),(select pxid from #plist where poid=growthbookid),nuid,[kinremarkitem],[homeremarkitem],[kinremark],[homeremark] from BasicData..init_Baseinfo 
inner join ebook..gb_weekremark on uid=userid


--ebook..hb_personalinfo
delete ebook..hb_personalinfo  from  ebook..hb_personalinfo p where not exists (select top 1 1 from ebook..gb_growthbook g where p.growthbookid=g.growthbookid)


insert into ebook..hb_personalinfo 
select (select pxid from #plist where poid=growthbookid),[username],[birthday],[nickname],[gender],[classname],[myphoto],[parentmessage],[fathername],[mathername],[fatherjob],[matherjob],[familyphoto],[personalsign],[favfood],[favgood],[farthing],[hatefood],[kinname],[drugsallergy]
from ebook..hb_personalinfo where  exists(select top 1 1 from #plist where poid=growthbookid)


update ebook..gb_growthbook set [bookver]=[bookver]-10 where [bookver]>5

drop table #plist
drop table #ulist
GO
