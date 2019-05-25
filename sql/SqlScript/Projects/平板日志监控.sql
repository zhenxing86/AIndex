--<model value="0" desc="一般运行日志"/>
--  <model value="1" desc="平板刷卡日志"/>
--  <model value="2" desc="红外枪刷卡日志"/>
--  <model value="3" desc="网络通讯相关日志"/>
--  <model value="4" desc="其他"/>

select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=2 and devicetype=1 --and d.devid='001251113' --and logmsg not like '%PostRunStatus执行了服务器命令，执行命令代码为%'
--and logmsg not like '%Disk space%'
order by logid desc

--公告信息已经过期
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=1 and logmsg like '%公告信息已经过期%'
order by logid desc

--版本更新
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=1 and logmsg like '%取消了版本更新%'
order by logid desc

select top 100 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=3 and devicetype=1 and logmsg like '%UpdateFirmware%'
order by logid desc

select top 10 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=10 and devicetype=0 and logmsg ='update fail'

--拍照异常
select top 10 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=0 and logmsg like '%拍照异常%'
order by logid desc

--系统时间不准
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=1 and logmsg like '%系统时间不准%'
order by logid desc

--刷卡失败日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=1 and logmsg like '%刷卡失败%'
order by logid desc


--未登记卡日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=1 and logmsg like '%未登记卡%'
order by logid desc

--写卡失败日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=1 and logmsg like '%写卡失败%'
order by logid desc

--(平板没有)
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=1 and logmsg like '%卡片密码验证失败%'
order by logid desc

--(平板没有)
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=1 and logmsg like '%卡信息没有找到%'
order by logid desc

select top 1 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=14 and devicetype=1 and logmsg like 'the card is not registered. card:%'

--数据上传日志（调用接口失败）
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=3 and devicetype=1 and logmsg like '%json%'
order by logid desc

select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=1 and logmsg like '%ViewActivity无法连接无线网络,本地未上传学生数量为：%'
order by logid desc

--数据采集日志（连接不上晨检枪）
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=2 and devicetype=1 and logmsg like '%Communicate%'
order by logid desc

--网络连接异常日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=3 and devicetype=1 and logmsg like '%网络连接%'
order by logid desc

init_stu_mc_day

--磁盘空间不足
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=16 and devicetype=0 and logmsg like '%Disk space%'
and cast(
			(case ISNUMERIC(REPLACE(REPLACE(logmsg,'Disk space ',''),'GB available','')) 
			 when 1 then REPLACE(REPLACE(logmsg,'Disk space ',''),'GB available','')
			else '0.0' end)
		 as float)<1.0
order by logid desc

--操作数据日常
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=4 and devicetype=1 
order by logid desc

LogInfo_ex

