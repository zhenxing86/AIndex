--1=采集红外枪的晨检记录的数量,2=同步学生资料条数,3=同步教师资料条数,4=上传晨检记录条数,
--5=上传出勤记录条数(已经废弃)，6=加载读卡器成功，7= 开卡成功，8=上位机网络连接异常，
--9= 与红外枪通信异常，10=版本更新失败，11=接口调用失败，12=加载读卡器失败，13=刷卡失败，
--14= 开卡失败，15=卡验证失败，16=访问access失败，17=上传pc端数据失败，18=其他，
--19=同步晨检枪参数（查询/修改），20=同步晨检枪参数（查询）出错，21=同步卡信息，
--22=同步晨检枪默认查询参数，23=一体机提示未登记卡，25=同步MU260设备信息，26=MU260出错信息，27=同MU266设备连接状态

--设备类型：0：一体机，1：平板，2：MU260,3：晨检枪

LogInfo
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=19 and devicetype=3 --and logmsg not like'%成功%' 
order by logid desc


--版本更新
select top 100 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=10 and devicetype>1 and logmsg <>'txtRegist_KeyDown' and logmsg not like '%版本成功！'
and logmsg <>'调用版本接口网关不存在'
order by logid desc

--系统时间不准( 这个还没有，最好加上)
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=0 and devicetype>1 and logmsg like '%系统时间不准%'
order by logid desc

--刷卡失败日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=13 and devicetype>1 
order by logid desc

--数据上传日志（调用json失败）
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=11 and devicetype>1 
order by logid desc

--数据上传日志（上传pc端数据失败）
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=17 and devicetype>1 
order by logid desc


--数据采集日志（连接不上晨检枪）
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=9 and devicetype>1
order by logid desc

--网络连接异常日志
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=8 and devicetype>1 and logmsg = '网络未连接'
order by logid desc

--加载读卡器失败
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=12 and devicetype>1 and logmsg = '加载读卡器失败'
order by logid desc

--操作数据库异常
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype=16 and devicetype>1 and logmsg like '%异常%'
order by logid desc

--MU260机器联网失败
select top 1000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where (logtype=27 or logtype=25)and devicetype=2
order by logid desc

--同步晨检枪参数（查询）出错
--select top 1000 l.* from mcapp..LogInfo l
--inner join mcapp..driveinfo d 
-- on l.devid=d.devid  
--where logtype=20 and devicetype=3 --and logmsg not like'%成功%' 
--order by logid desc



