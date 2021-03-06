USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[init_Baseinfo_distinct_userid]    Script Date: 06/15/2013 15:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--只初始化usertype <> 98的用户数据
CREATE PROCEDURE [dbo].[init_Baseinfo_distinct_userid]

as


create table #ulist
(
	xuid int,
	xcount int,
	xnuid int,
	rnuid int
) 
insert into #ulist
select uid,count(nuid),min(nuid),1 from BasicData..init_Baseinfo group by uid having count(nuid)>1

insert into #ulist
select uid,0,nuid,xnuid from BasicData..init_Baseinfo 
inner join #ulist on uid=xuid 

--select * from #ulist where xcount=0
--班级同步user_class
insert into #ulist
select cid,-1,xnuid,rnuid from BasicData..user_class 
inner join #ulist on userid=xnuid and xcount=0

delete from BasicData..user_class where userid in (select xnuid from #ulist where xcount=-1)

insert into BasicData..user_class 
select xuid,rnuid from #ulist where xcount=-1

delete from #ulist where xcount=-1

--基本信息同步user_baseinfo
delete basicData..user_baseinfo where userid in
(select xnuid from #ulist where xcount=0 and xnuid<>rnuid)

--幼儿信息child
delete basicData..child where userid in
(select xnuid from #ulist where xcount=0 and xnuid<>rnuid)

--老师信息child
delete basicData..teacher where userid in
(select xnuid from #ulist where xcount=0 and xnuid<>rnuid)

--登录信息
delete basicData..[user] where userid in
(select xnuid from #ulist where xcount=0 and xnuid<>rnuid)


--幼儿园关系
delete basicData..user_kindergarten where userid in
(select xnuid from #ulist where xcount=0 and xnuid<>rnuid)


drop table #ulist
GO
