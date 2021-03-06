USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[Msg_Sms_Report]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Msg_Sms_Report]
@kid int--幼儿园ID，当为0的时候发送所有幼儿园
AS

declare @ntime datetime,@llogtime datetime,@rtime datetime
set @ntime=convert(varchar(10),getdate(),120)
set @llogtime=dateadd(dd,-7,@ntime)
set @rtime=dateadd(dd,-7,@ntime)
create table #temp_uid
(
	xkid int,
	xuid int
)


create table #temp
(
	lkid int,
	luid int,
	lprivince nvarchar(100),
	lcity nvarchar(100),
	lkname nvarchar(50)
)

insert into #temp_uid(xkid,xuid)
select u.kid,u.userid from  basicdata..[user] u
where (u.kid=@kid or @kid=0) 


insert into #temp(lkid,luid,lprivince,lcity,lkname)
select c.xkid,c.xuid,basicdata.dbo.areacaptionfromid(d.privince),basicdata.dbo.areacaptionfromid(d.city),d.kname from  #temp_uid c
inner join basicdata..kindergarten d on d.kid=c.xkid
inner join kwebcms..site_config e on e.siteid=c.xkid
inner join basicdata..[user] a on c.xuid=a.userid
 where  e.isvip=1 and (lastlogindatetime is null or lastlogindatetime<@llogtime) and a.usertype=0
and replace(mobile,' ','') <>''  and mobile is not null  


select lprivince,lcity,lkid,lkname,count(1) from #temp a
inner join remindsmscount r on r.userid=a.luid
left join MsgApp..remindsmsread d on  d.readtime>@rtime and d.userid=a.luid
where  unreadcount>0 
and d.readtime is null
group by lprivince,lcity,lkid,lkname order by count(1) desc

drop table #temp_uid
drop table #temp


GO
