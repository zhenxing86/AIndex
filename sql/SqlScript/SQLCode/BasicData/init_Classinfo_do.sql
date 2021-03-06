USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[init_Classinfo_do]    Script Date: 06/15/2013 15:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--只初始化usertype <> 98的用户数据
CREATE PROCEDURE [dbo].[init_Classinfo_do]

as

create table #ulist
(
	oid int,
	nid int,
	xid int
) 

--导入班级公告
delete classapp..class_notice where userid in (select nuid from BasicData..init_Baseinfo)

insert into classapp..class_notice
select title,nuid,author,i.nkid,i.ncid,[content],createdatetime,status+10 from BasicData..init_Baseinfo i
inner join classapp..class_notice c on c.userid=i.uid order by createdatetime

--公告班级关系
insert into #ulist(oid,nid)
select classid,noticeid from classapp..class_notice where status>5 order by createdatetime

delete classapp..class_notice_class where classid in (select ncid from BasicData..init_Baseinfo)

insert into classapp..class_notice_class
select oid,nid from #ulist

update classapp..class_notice set status=status-10 where status>5
delete #ulist

--班级相册(class_album,class_photos)
delete classapp..class_album where userid in (select nuid from BasicData..init_Baseinfo)

insert into classapp..class_album
select [title],[description],[photocount],ncid,[nkid],nuid,[author],[createdatetime],[status]+10,[coverphoto],[coverphotodatetime] from BasicData..init_Baseinfo i
inner join classapp..class_album c on c.userid=i.uid order by createdatetime
--先获取旧的albumid和新的userid
insert into #ulist(oid,nid)
select albumid,nuid from classapp..class_album a
inner join BasicData..init_Baseinfo i on i.uid=a.userid order by albumid
--通过新的userid来同步获取新的albumid
update #ulist set xid=albumid from classapp..class_album where status>5 and nid=userid
--oid=旧的albumid，nid-新的userid，xid=新的albumid

delete classapp..class_photos where albumid in (select xid from #ulist)


insert into classapp..class_photos 
select (select top 1 xid from #ulist where oid=p.albumid),p.[title],[filename],[filepath],[filesize],[viewcount],[commentcount],[uploaddatetime],[iscover],[isfalshshow],[orderno],p.[status]
 from classapp..class_photos p
where albumid in 
(select albumid from classapp..class_album a 
inner join BasicData..init_Baseinfo i on i.uid=a.userid)--不用left，有的用户不存在，照片还在

update classapp..class_album set status=status-10 where status>5
delete #ulist

--教学安排(class_schedule,class_scheduleattach,class_schedulecomments,class_schedulemastercomment)
delete classapp..class_schedule where classid in (select ncid from BasicData..init_Baseinfo)

insert into classapp..class_schedule
select [title],
(select top 1 nuid from BasicData..init_Baseinfo where cid=classid) nuid,[author],
(select top 1 ncid from BasicData..init_Baseinfo where cid=classid) ncid,
(select top 1 [nkid] from BasicData..init_Baseinfo where cid=classid) [nkid],[content],[createdatetime],[viewcount],[commentcount],[status]+10 
from classapp..class_schedule c  
where classid in (select distinct cid from BasicData..init_Baseinfo) order by createdatetime




--先获取旧的albumid和新的userid
insert into #ulist(oid,nid)
select scheduleid,nuid from classapp..class_schedule a
inner join BasicData..init_Baseinfo i on i.uid=a.userid
--通过新的userid来同步获取新的albumid
update #ulist set xid=scheduleid from classapp..class_schedule where status>5 and nid=userid
--oid=旧的albumid，nid-新的userid，xid=新的albumid

--class_scheduleattach
delete classapp..class_scheduleattach where scheduleid in (select xid from #ulist)

insert into classapp..class_scheduleattach 
select (select top 1 xid from #ulist where oid=p.scheduleid),p.[title],[filename],[filepath],p.[createdatetime],[filesize]
 from classapp..class_scheduleattach p
inner join classapp..class_schedule a on p.scheduleid=a.scheduleid
inner join BasicData..init_Baseinfo i on i.uid=a.userid

--class_schedulecomments
delete classapp..class_schedulecomments where scheduleid in (select xid from #ulist)

insert into classapp..class_schedulecomments 
select (select top 1 xid from #ulist where oid=p.scheduleid),(select top 1 nuid from BasicData..init_Baseinfo where uid=p.[userid]),p.[author],p.[content],[commentdatetime],[parentid]
 from classapp..class_schedulecomments p
inner join classapp..class_schedule a on p.scheduleid=a.scheduleid
inner join BasicData..init_Baseinfo i on i.uid=a.userid


update classapp..class_schedule set status=status-10 where status>5
delete #ulist

drop table #ulist
GO
