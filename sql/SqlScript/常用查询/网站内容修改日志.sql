select * from AppLogs.dbo.app_process_log




--登录后台日志
select b.account, b.name, a.actiondatetime, a.asctiondesc from applogs.dbo.appcenter_log a, BasicData.dbo.[user] b
 where appid=99 and a.userid = b.userid and b.kid = 23713 and a.actiondatetime>='2018-10-08'
  order by id desc 
 

--网站内容修改日志
select actiondatetime, actiondesc,id from kwebcms.dbo.actionlogs a, BasicData.dbo.[user] b
 where a.userid = b.userid and b.kid = 23713 and a.actiondatetime>='2018-10-08'
union all
select actiondatetime, actiondesc,id from kwebcms.dbo.actionlogs_history
 where kid = 23713 and actiondatetime>='2018-10-08' 
 order by id desc
 
 
 ----------------------------------------------
 
--博客操作日志
select * from applogs.dbo.blog_log order by actionid desc
select * from applogs.dbo.blog_new_actionlogs order by actionid desc

--权限修改日志
select * from applogs.dbo.permissionsetting_log

--登录后台日志
select top 6000* from applogs.dbo.appcenter_log where appid=99 order by id desc 

--网站内容修改日志
select top 6000* from kwebcms.dbo.actionlogs order by id desc
select top 6000* from kwebcms.dbo.actionlogs_history order by id desc


--登录后台日志
select b.account, b.name, a.actiondatetime, a.asctiondesc from applogs.dbo.appcenter_log a, BasicData.dbo.[user] b where appid=99 and a.userid = b.userid and b.kid = 23713 order by id desc 

--网站内容修改日志
select top 6000* from kwebcms.dbo.actionlogs a, BasicData.dbo.[user] b where a.userid = b.userid and b.kid = 23713 order by id desc
select actiondatetime, actiondesc from kwebcms.dbo.actionlogs_history where kid = 23713 order by id desc


