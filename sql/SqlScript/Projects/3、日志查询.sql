
--ossapp..keylog_Add


--查某个幼儿园的某个时间范围内的修改[user]表的日志
select l.DoUserID,l.CrtDate,u1.name doname, u.userid,u.account,u.name,l.ColName,l.OldValue,l.NewValue,l.DoWhere,l.HostName
  from BasicData..[user] u inner join 
AppLogs.dbo.EditLog l on u.userid=l.KeyCol -- and u.kid=33078
 left join BasicData..[user] u1 on l.DoUserID=u1.userid
 where --l.CrtDate >'2017-08-24' -- between '2016-07-01' and '2016-07-08'
 l.DbName='BasicData' and l.TbName='user'
and l.KeyCol in(2485595)
 order by CrtDate
 
，这个小朋友原来的名字是李媛媛，不知道为什么今天突然看到显示李轩成了，他们是两兄妹，麻烦你帮我查下是不是家长手机进去改名字了

select * from basicdata..[user] where kid=37586 and  name='李轩成'

select * from basicdata..user_add_new_exec where account in('13704517875','15004617277')

--查询调班记录
select * from kmapp.dbo.user_class_update_history where userid=2371833
select * from BasicData..user_class_all where userid=2371833
select * from AppLogs.dbo.EditLog where DbName='BasicData' and TbName='user_class' and KeyCol2=2371833
select * from BasicData..weixin_user_class_update where userid=2371833
 
select *
  from AppLogs.dbo.EditLog l
 where l.CrtDate >'2010-03-04' -- between '2016-07-01' and '2016-07-08'
and l.DbName='mcapp' and l.TbName='kindergarten'
and l.KeyCol = 34333
 order by CrtDate
 

;with cet as(
select l.DoUserID,u1.name doname, u.userid,u.account,u.name,u.kid,l.*
  from BasicData..[user] u inner join 
AppLogs.dbo.EditLog l on u.userid=l.KeyCol --and u.kid=21620 --and colname='password'
 left join BasicData..[user] u1 on l.DoUserID=u1.userid
 where --l.CrtDate >'2010-01-24' and -- between '2016-07-01' and '2016-07-08'
 l.DbName='BasicData' and l.TbName='user'
and l.KeyCol = 2163656
 order by CrtDate
)



select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='kf.zgyey.com' and convert(varchar(10),happendate,120)='2016-09-29'
select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='bapp.zgyey.com' and convert(varchar(10),happendate,120)='2016-09-29'
select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='sms.zgyey.com' and convert(varchar(10),happendate,120)='2016-09-29'
select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='oss.zgyey.com' and convert(varchar(10),happendate,120)='2016-09-29'
select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='mcgw.zgyey.com' and convert(varchar(10),happendate,120)='2016-09-29'  --无
select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='mcapp.zgyey.com' and convert(varchar(10),happendate,120)='2016-04-23'
select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='m.sms.zgyey.com' and convert(varchar(10),happendate,120)='2016-09-29'  --无

select convert(varchar(10),crtdate,120),COUNT(*) from AppLogs.dbo.mc_log where ftype=1 and category='处理异常' and crtdate>='2016-09-29'
group by convert(varchar(10),crtdate,120)  --smstimer

select convert(varchar(10),logtime,120),COUNT(*)  from BigLog..loginfo_ex where logtype=10 and smalllogtype=2 and logtime>='2016-09-29'
group by convert(varchar(10),logtime,120) --mcdatatimer/mclogtime

select COUNT(*) from logdata.dbo.[procerrorlog] where appname ='kmapp.zgyey.com' and convert(varchar(10),happendate,120)='2016-09-29'  --无
declare @app nvarchar(2000)='bapp,sms,oss,tmcgw,mcapp,m.sms,kmapp'
select col+'.zgyey.com' appname into #t
from CommonFun.dbo.f_split(@app,',')
select p.appname, convert(varchar(10),p.happendate,120),COUNT(*) from logdata.dbo.[procerrorlog] p
 inner join #t t on p.appname=t.appname
  where p.happendate>'2016-09-29'
group by p.appname, convert(varchar(10),p.happendate,120)
order by p.appname, convert(varchar(10),p.happendate,120)
drop table #t

select * from AppLogs.dbo.mc_log where ftype=1 and category='处理异常' and crtdate>='2015-12-19 17:00' order by crtdate --smstimer
select * from AppLogs.dbo.mc_log where ftype=1 and crtdate>='2015-12-19 18:00' order by crtdate --smstimer

select * from BigLog..loginfo_ex where logtype=10 and smalllogtype=2 and logtime>='2015-12-28'  --mcdatatimer/mclogtime


select * from BigLog..loginfo_ex where logtype=10 and smalllogtype=5 and logtime>='2015-12-28'  --mcdatatimer/mclogtime
select * from logdata.dbo.[procerrorlog] where appname ='kmapp.zgyey.com' and happendate>='2015-12-24'  --无


select * from logdata.dbo.[procerrorlog] where appname ='bapp.zgyey.com' and happendate>='2016-09-29'
select * from logdata.dbo.[procerrorlog] where appname ='sms.zgyey.com' and happendate>='2016-09-29'
select * from logdata.dbo.[procerrorlog] where appname ='oss.zgyey.com' and happendate>='2016-09-29'
select * from logdata.dbo.[procerrorlog] where appname ='mcgw.zgyey.com' and happendate>='2016-05-16' order by happendate --无
select * from logdata.dbo.[procerrorlog] where appname ='mcapp.zgyey.com' and happendate>='2017-03-28' order by happendate
select * from logdata.dbo.[procerrorlog] where appname ='m.sms.zgyey.com' and happendate>='2016-09-29' --无
select * from logdata.dbo.[procerrorlog] where appname ='kmapp.zgyey.com' and happendate>='2016-09-29'  --无
select * from logdata.dbo.[procerrorlog] where appname ='kf.zgyey.com' and happendate>='2016-09-29'  --无

select *from AppLogs..sgs_log where adddate>='2016-09-29' and clientid<>''


select * from logdata.dbo.[procerrorlog] where appname ='mcapp.zgyey.com' and happendate>='2016-04-23'
select *from BasicData..[user] where userid=1603394


select * from AppLogs..appcenter_log  l
 inner join BasicData..[user] u
  on l.userid=u.userid and l.actiondatetime>='2016-08-01'
  order by l.id desc
  
select * from KWebCMS..actionlogs_history l  --where l.actiondatetime>='2016-08-01'
 inner join KWebCMS..site_user  u
  on l.userid=u.userid
   and u.siteid= 12511 --and l.actiondatetime>='2016-08-01'
  order by l.id desc
  
  
select * from KWebCMS..actionlogs_history l 
 inner join KWebCMS..site_user  u
  on l.userid=u.userid
   and u.siteid= 4431 --and l.actiondatetime>='2016-08-01'
  order by l.id desc
  
