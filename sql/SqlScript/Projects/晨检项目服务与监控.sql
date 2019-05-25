
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

--设备类型：0：一体机，1：平板，2：MU260,3：晨检枪

--数据上传日志  
--采集器/MU260  logtype=11  logmsg like '调用学生晨检接口失败：%'
--一体机  logtype=11  logmsg 不能确定，需要完善。？？？
--平板

logtype=1 or 
select top 10000 l.* from mcapp..LogInfo l
inner join mcapp..driveinfo d 
 on l.devid=d.devid  
where logtype>=0 and devicetype=1
order by logid desc

select top 2000* from mcapp..LogInfo where logtype=2 and devid like '%[1-2][0-9]' --and logmsg like '调用学生晨检接口失败：%'
order by logid desc

proc 
输入：日志时间  上传时间
输出：
kid kname devid gunid upcnt recordcnt 

--数据通讯日志
开始采集时间：2014-5-21 9:19:05，采集结束时间：2014-5-21 9:22:41，共采集数量：303条
--数据采集日志

driveinfo

--系统时间异常日志

--网络连接异常

--存储空间不足预警  (查询今天上传日志的最近一次显示的磁盘大小《1G的数据)
mcapp..rep_mcdata_harddisk
Kid,Kname,Devid,Gunid,diskspace,Content,logtime


select * from mcapp..driveinfo
 where kid=@kid and 
 select Kid,Kname,Devid,Gunid,diskspace,Content,logtime 
 from  
  mcapp..loginfo   
  where logtype = 16  
  and kid = @kid and devid=@ 
  and logtime >= CONVERT(VARCHAR(10),@bgndate,120)  
  and logtime < CONVERT(VARCHAR(10),DATEADD(DD,1,@enddate),120)  
  

ossapp..GetCustomer_SelectList

select distinct Category from dbo.CustomerService
select * from dbo.CustomerService 