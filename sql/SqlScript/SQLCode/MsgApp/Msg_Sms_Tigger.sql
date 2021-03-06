USE [MsgApp]
GO
/****** Object:  StoredProcedure [dbo].[Msg_Sms_Tigger]    Script Date: 2014/11/24 23:15:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[Msg_Sms_Tigger] 11061,0

CREATE PROCEDURE [dbo].[Msg_Sms_Tigger]
@kid int,--幼儿园ID，当为0的时候发送所有幼儿园
@typeid int--指定发送对象（0，发送所有收费幼儿园的所有小朋友，1，收费幼儿园中收费的小朋友。）
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
	mobile varchar(100),
	lname nvarchar(100),
	account varchar(100)
)

insert into #temp_uid(xkid,xuid)
select u.kid,u.userid from  basicdata..[user] u
where (u.kid=@kid or @kid=0) 

if (@typeid=0) 
begin

insert into #temp(lkid,luid,mobile,lname,account)
select c.xkid,c.xuid,a.mobile,a.[name],a.account from  #temp_uid c
inner join basicdata..[user] a on c.xuid=a.userid
inner join kwebcms..site_config e on e.siteid=c.xkid
 where (lastlogindatetime is null or lastlogindatetime<@llogtime) and a.usertype=0
and replace(mobile,' ','') <>''  and mobile is not null  and e.isvip=1

select replace(a.mobile,' ',''),0,
'尊敬的'+a.[lname]+'小朋友家长，幼儿园有最新动态更新了，请登录网站查看更多精彩内容。登录账号：'+a.account+',登录网址app.zgyey.com'
,getdate(),getdate(),a.lkid from #temp a
inner join remindsmscount r on r.userid=a.luid
left join MsgApp..remindsmsread d on  d.readtime>@rtime and d.userid=a.luid
where unreadcount>0 and d.readtime is null

end
else if (@typeid=1) 
begin

insert into #temp(lkid,luid,mobile,lname,account)
select c.xkid,c.xuid,a.mobile,a.[name],a.account from  #temp_uid c
inner join basicdata..[user] a on c.xuid=c.xuid
inner join basicdata..child f on a.userid=f.userid
 where (lastlogindatetime is null or lastlogindatetime<@llogtime) and a.usertype=0
and replace(mobile,' ','') <>''  and mobile is not null and f.vipstatus=1 

select replace(a.mobile,' ',''),0,
'尊敬的'+a.[lname]+'小朋友家长，幼儿园有最新动态更新了，请登录网站查看更多精彩内容。登录账号：'+a.account+',登录网址app.zgyey.com'
,getdate(),getdate(),a.lkid from #temp a
inner join remindsmscount r on r.userid=a.luid
left join MsgApp..remindsmsread d on  d.readtime>@rtime and d.userid=a.luid
where unreadcount>0 and d.readtime is null

end

drop table #temp_uid
drop table #temp



GO
