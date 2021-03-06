USE [ReportApp]
GO
/****** Object:  StoredProcedure [dbo].[rep_Class_Info_Report]    Script Date: 2014/11/24 23:24:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[rep_Class_Info_Report] 
@kid int
AS

create table #tempList
(
lrow int IDENTITY(1,1),
gid int,
gname varchar(50),
lcid int,
cname varchar(50),
childcount int,
zteachar varchar(200),
fteachar varchar(200),
bteachar varchar(200),
kteachar varchar(200),
gorder int,
corder int
)


create table #tempteachar
(
trow int IDENTITY(1,1),
gid int,
gname varchar(50),
tcid int,
cname varchar(50),
post varchar(50),
tname varchar(50),
tuid int
)

insert into #tempList
SELECT gid,gname,t2.cid,t2.cname 
,(select count(1) from basicdata..[user] u inner join basicdata..user_class c on u.userid=c.userid where usertype=0 and deletetag=1 and u.deletetag=1 and c.cid=t2.cid) childcount
,'','','','', t1.[order], t2.[order] from basicdata..grade t1  
inner join  basicdata..class  t2  on t1.gid=t2.grade 
where t2.grade<>38 and t2.kid=@kid and t2.deletetag=1 order by  t1.[order], t2.[order] asc


insert into #tempteachar
select gid,gname,u.lcid,u.cname,t.title,r.[name],r.userid from #tempList u
inner join basicdata..user_class c on u.lcid=c.cid 
inner join basicdata..teacher t on t.userid=c.userid and title in('主班老师','副班老师','保育员','专科老师')
inner join BasicData..[user] r on r.userid=c.userid  and r.deletetag=1 and r.usertype=1



declare @count int,@i int
select @count=count(1) from #tempteachar
set @i=1
while (@i<=@count)
begin

update #tempList set zteachar=tname+','+zteachar from 
 #tempteachar where trow=@i and tcid=lcid and post='主班老师'

update #tempList set fteachar=tname+','+fteachar from 
 #tempteachar where trow=@i and tcid=lcid and post='副班老师'

update #tempList set bteachar=tname+','+bteachar from 
 #tempteachar where trow=@i and tcid=lcid and post='保育员'

update #tempList set kteachar=tname+','+kteachar from 
 #tempteachar where trow=@i and tcid=lcid and post='专科老师'
set @i=@i+1
end

declare @c1 int,@c2 int,@c3 int,@c4 int,@c5 int,@c6 int


select @c1=count(distinct lcid) from #tempList 
select @c2=sum(childcount) from #tempList
select @c3=count(distinct tuid) from #tempteachar where post='主班老师'
select @c4=count(distinct tuid) from #tempteachar where post='副班老师'
select @c5=count(distinct tuid) from #tempteachar where post='保育员'
select @c6=count(distinct tuid) from #tempteachar where post='专科老师'

insert into #tempList(gname,cname,childcount,zteachar,fteachar,bteachar,kteachar,gorder)
values ('合计',@c1,@c2,@c3,@c4,@c5,@c6,9999999)

select gname,cname,childcount,zteachar,fteachar,bteachar,kteachar,case when lcid is null then 0 else lcid end lcid from #tempList order by gorder,corder 


drop table #tempteachar
drop table #tempList

GO
