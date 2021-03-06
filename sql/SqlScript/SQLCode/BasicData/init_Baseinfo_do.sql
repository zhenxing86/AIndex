USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[init_Baseinfo_do]    Script Date: 06/15/2013 15:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_Baseinfo_do]
(
@kid int,--需要取的幼儿园ID，必须大于0
@tokid int,--如果全部新建为-1，目标幼儿园，大于0的时候目标
@account_pre varchar(10)
)
as

if(@tokid=-1)
begin
insert into BasicData..kindergarten
select kname,address,privince,city,area,5,actiondate,telephone,qq,1,5,8,0 from BasicData..kindergarten where kid=@kid
select @tokid=kid from BasicData..kindergarten where deletetag=5

update BasicData..kindergarten set deletetag=1 where deletetag=5


--初始化BasicData..init_Baseinfo表的时候先把相关的所有数据删除
delete BasicData..[user] where userid in (select nuid from BasicData..init_Baseinfo)
delete BasicData..class where cid in (select ncid from BasicData..init_Baseinfo)
delete from BasicData..user_baseinfo where userid in (select nuid from BasicData..init_Baseinfo)
delete from BasicData..user_kindergarten where kid=@tokid
delete BasicData..user_class where cid in (select ncid from BasicData..init_Baseinfo)

--classapp数据库
delete from classapp..class_notice where kid=@tokid
delete classapp..class_notice_class where classid in (select ncid from BasicData..init_Baseinfo)
delete classapp..class_photos where albumid in (select albumid from classapp..class_album where kid=@tokid)
delete from classapp..class_album where kid=@tokid
delete from classapp..class_schedulecomments where userid in (select nuid from BasicData..init_Baseinfo)
delete classapp..class_scheduleattach where scheduleid in (select scheduleid from classapp..class_schedule where kid=@tokid)
delete from classapp..class_schedule where kid=@tokid

--ebook数据库
delete ebook..hb_personalinfo where growthbookid in (select growthbookid from ebook..gb_growthbook where exists (select top 1 1 from BasicData..init_Baseinfo where userid=nuid) )
delete from ebook..gb_weekremark where userid in (select nuid from BasicData..init_Baseinfo)
delete from ebook..gb_termremark where userid in (select nuid from BasicData..init_Baseinfo)
delete ebook..hb_homebook where classid in (select ncid from BasicData..init_Baseinfo)

delete from ebook..gb_growthbook where exists (select top 1 1 from BasicData..init_Baseinfo where userid=nuid)

--初始化BasicData..init_Baseinfo表的时候先把相关的所有数据删除


delete BasicData..init_Baseinfo

insert into BasicData..init_Baseinfo(kid,cid,uid,did,xid,nkid)
select distinct r.kid,c.cid,u.userid,t.did,convert(varchar,ROW_NUMBER() OVER(ORDER BY u.userid)) xid,@tokid 
from BasicData..[user]  u 
left join BasicData..user_class c on c.userid=u.userid
inner join BasicData..user_kindergarten r on r.userid=u.userid
left join BasicData..teacher t on t.userid=u.userid
where r.kid=@kid and u.deletetag=1   order by u.userid

end
else 
begin

delete from BasicData..[user] where userid in (select userid from user_kindergarten where kid=@tokid) and usertype <> 98
delete from BasicData..class where kid=@tokid
delete from BasicData..department where kid=@tokid
delete from BasicData..user_kindergarten where kid=@tokid and userid not in (select userid from [user] where  usertype = 98)

delete BasicData..init_Baseinfo

insert into BasicData..init_Baseinfo(kid,cid,uid,did,xid,nkid)
select distinct r.kid,c.cid,r.userid,t.did,convert(varchar,ROW_NUMBER() OVER(ORDER BY r.userid)) xid,@tokid 
from BasicData..[user]  u 
left join BasicData..user_class c on c.userid=u.userid
left join BasicData..user_kindergarten r on r.userid=u.userid
left join BasicData..teacher t on t.userid=u.userid
where r.kid=@kid and u.deletetag=1 and u.usertype <> 98  order by r.userid



end



--基础
insert into BasicData..[user]
select (select top 1 [name] from BasicData..user_baseinfo where userid=i.uid)+@account_pre+convert(varchar,xid),'7C4A8D09CA3762AF61E59520943DC26494F8941B',usertype,5,regdatetime,lastlogindatetime 
from  BasicData..init_Baseinfo i
inner join BasicData..[user] u on u.userid=i.uid order by u.userid --group by i.uid


create table #ulist
(
	userid int,
	xuid int,
	xname varchar(100)
) 


insert into #ulist(userid,xuid)
select userid,convert(varchar,ROW_NUMBER() OVER(ORDER BY userid)) xid  from  BasicData..[user] where deletetag=5  order by userid

update BasicData..init_Baseinfo  set nuid=userid from #ulist where xuid=xid
update BasicData..[user] set deletetag=1 where deletetag=5

--班级
insert into BasicData..class
select (select top 1 nkid from BasicData..init_Baseinfo i where i.kid=c.kid),cname,grade,[order],5,sname,actiondate,iscurrent,subno from BasicData..class c 
where cid in(select distinct cid from BasicData..init_Baseinfo)

delete #ulist
insert into #ulist(userid,xname)
select cid,cname from BasicData..class where deletetag=5

update #ulist set xuid=cid from BasicData..class  where cname=xname and kid=@kid
update BasicData..init_Baseinfo  set ncid=userid from #ulist  where xuid=cid
update BasicData..class set deletetag=1 where deletetag=5

--部门
delete #ulist
insert into BasicData..department
select dname,0,[order],5,(select top 1 nkid from BasicData..init_Baseinfo i where i.kid=c.kid),actiondatetime from BasicData..department c where deletetag=1 and kid=@kid 


insert into #ulist(userid,xname,xuid)
select did,dname,convert(varchar,ROW_NUMBER() OVER(ORDER BY did)) xid from BasicData..department where deletetag=5

update BasicData..init_Baseinfo  set ndid=userid from #ulist,BasicData..init_Baseinfo i 
where xname=(select top 1 dname from BasicData..department b where b.did=i.did)
update BasicData..department set deletetag=1 where deletetag=5


--默认更新did部门信息
declare @d int,@nd int
select top 1 @d=i.did,@nd=ndid from BasicData..init_Baseinfo i
inner join BasicData..department d on i.did=d.did and superior=0 
update BasicData..init_Baseinfo set did=@d,ndid=@nd where did is null or ndid is null



insert into BasicData..user_kindergarten
select nuid,nkid from BasicData..init_Baseinfo where nuid is not null


update BasicData..department set superior=ndid from 
BasicData..department b
inner join BasicData..init_Baseinfo i on i.did=b.superior where b.kid=@tokid

update BasicData..department set superior=0 where superior is null


drop table #ulist
GO
