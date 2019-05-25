--1=采集红外枪的晨检记录的数量,2=同步学生资料条数,3=同步教师资料条数,4=上传晨检记录条数,
--5=上传出勤记录条数(已经废弃)，6=加载读卡器成功，7= 开卡成功，8=上位机网络连接异常，
--9= 与红外枪通信异常，10=版本更新失败，11=接口调用失败，12=加载读卡器失败，13=刷卡失败，
--14= 开卡失败，15=卡验证失败，16=访问access失败，17=上传pc端数据失败，18=其他，
--19=同步晨检枪参数（查询/修改），20=同步晨检枪参数（查询）出错，21=同步卡信息，
--22=同步晨检枪默认查询参数，23=一体机提示未登记卡，25=同步MU260设备信息，26=MU260出错信息，27=同MU266设备连接状态

--<model value="0" desc="一般运行日志"/>
--  <model value="1" desc="平板刷卡日志"/>
--  <model value="2" desc="红外枪刷卡日志"/>
--  <model value="3" desc="网络通讯相关日志"/>
--  <model value="4" desc="其他"/>

select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=13 and devicetype=0 --and logmsg like'%不支持的串口初始化操作' 
order by logid desc

select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=4 and devicetype=0 and d.devid='001251113' --and logmsg not like '%PostRunStatus执行了服务器命令，执行命令代码为%'
order by logid desc

--监听串口错误
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=0 and (logmsg like'%不支持的串口初始化操作' 
 or logmsg like '%监听串口错误')
order by logid desc


--公告信息已经过期
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=0 and logmsg like '%公告信息已经过期%'
order by logid desc

--版本更新 (一体机没有)
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=0 and logmsg like '%取消了版本更新%'
order by logid desc

--版本更新 (一体机)
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=10 and devicetype=0 and logmsg ='update fail'
order by logid desc

--拍照异常(一体机没有)
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=0 and logmsg like '%拍照异常%'
order by logid desc

--系统时间不准
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype=0 and logmsg like '%系统时间不准%'
order by logid desc

--刷卡失败日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=0 and logmsg like '%刷卡失败%'
order by logid desc


--未登记卡日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=0 and logmsg like '%未登记卡%'
order by logid desc

--写卡失败日志(一体机没有)
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=0 and logmsg like '%写卡失败%'
order by logid desc

select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=0 and logmsg like '%卡片密码验证失败%'
order by logid desc

select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=1 and devicetype=0 and logmsg like '%卡信息没有找到'
order by logid desc



--开卡失败
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=14 and devicetype=0 and logmsg like 'the card is not registered. card:%'
order by logid desc

--加载读卡器失败
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=12 and devicetype=0 and logmsg like '%Reader load fail%'
order by logid desc


--数据上传日志（调用接口失败）
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=3 and devicetype=0 and logmsg like '%json%'
order by logid desc


--数据采集日志（连接不上晨检枪）
select top 1000 l.* from mcapp..LogInfo l --(一体机有，好像是新版本有)
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=2 and devicetype=0 and logmsg like '%晨检枪链接失败%'
order by logid desc

select top 1000 l.* from mcapp..LogInfo l   --(一体机有)
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=9 and devicetype=0 and logmsg ='the gun fail to connected'
order by logid desc


--网络连接异常日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=3 and devicetype=0 and logmsg like '%网络连接%'
order by logid desc

select top 1000 l.* from mcapp..LogInfo l  --(一体机以此为准)
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=8 and devicetype=0 and logmsg ='Network connected fail'
order by logid desc

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




