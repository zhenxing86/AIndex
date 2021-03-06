USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[mm_init_loginfo_ex]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- Author:     xie  
-- Create date: 2014-06-20            
-- Description:  某段时间各异常日志总表        
-- Memo:    
输出：Kid,Kname,Devid,devicetype,logtype,smalllogtype,logcnt  
            
exec mm_memory_nospace   
  
update l set ftype=1   
 from mcapp..LogInfo l  
  inner join @HAVE_MOVE m on l.logid =m.ID  
    
    update LogInfo set ftype=0 where ftype=1
    delete from loginfo_ex 
    select count(1) from loginfo_ex  --2604992
    select * from loginfo_ex where logtype=8 and smalllogtype=1
    
*/  

CREATE proc [dbo].[mm_init_loginfo_ex]  
as  
begin  
 SET NOCOUNT ON  
 declare @HAVE_MOVE TABLE (ID INT,devicetype int,logtype int,smalllogtype int,result float default (0)) 
  
--版本更新  
--采集器  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)  
select logid,d.devicetype,1,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=10 and devicetype>1 and logmsg <>'txtRegist_KeyDown' and logmsg not like '%版本成功！'  
and logmsg <>'调用版本接口网关不存在' and ftype=0  

--一体机  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,1,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=10 and devicetype in(0,1) and logmsg ='update fail' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,1,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype=1 and logmsg like '%取消了版本更新%' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,1,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=3 and devicetype in (0,1) and logmsg like '%UpdateFirmware%' and ftype=0  
  
--连接不上晨检枪  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,2,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=9 and devicetype>1 and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,2,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=2 and devicetype=0 and logmsg like '%晨检枪链接失败%' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,2,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=9 and devicetype=0 and logmsg ='the gun fail to connected' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,2,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=2 and devicetype=1 and logmsg like '%Communicate%' and ftype=0  
  
--监听串口错误  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,2,2 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype=0 and (logmsg like'%不支持的串口初始化操作'   
 or logmsg like '%监听串口错误') and ftype=0  
  
  
--网络通信（调用网关json）  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,3,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=11 and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,3,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=17 and devicetype>1 and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,3,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=3 and devicetype in(0,1) and logmsg like '%json%' and ftype=0  
  
--网络连接  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,4,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=8 and devicetype>1 and logmsg = '网络未连接' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,4,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=3 and devicetype in(0,1) and logmsg like '%网络连接%' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,4,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=8 and devicetype=0 and logmsg ='Network connected fail' and ftype=0  
  
--加载读卡器失败  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=12 and devicetype>1 and logmsg = '加载读卡器失败' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=12 and devicetype=0 and logmsg like '%Reader load fail%' and ftype=0  
  
--读取卡片信息错误  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,2 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=1 and devicetype in(0,1) and logmsg like '%卡片密码验证失败%' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,2 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=1 and devicetype in(0,1) and logmsg like '%卡信息没有找到' and ftype=0  
  
--刷卡失败  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,3 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=1 and devicetype in(0,1) and logmsg like '%刷卡失败%' and ftype=0  
  
  
--写卡失败  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,4 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=13 and devicetype>1 and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,4 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=1 and devicetype in(0,1) and logmsg like '%写卡失败%' and ftype=0  
  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,4 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=14 and devicetype in(0,1) and logmsg like 'the card is not registered. card:%' and ftype=0  
  
--未登记卡  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,5,5 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=1 and devicetype in (0,1) and logmsg like '%未登记卡%' and ftype=0  
  
--操作数据库  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,6,1 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=16 and devicetype>1 and logmsg like '%异常%' and ftype=0  
  
  
--获取基本配置出错  

--语音服务绑定失败 
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,2 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype=1 and logmsg like '%语音服务绑定失败%' and ftype=0  
--拍照异常  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,3 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype=1 and logmsg like '%拍照异常%' and ftype=0  
  
--屏幕亮度设置失败  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,4 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype=1 and logmsg like '%屏幕亮度设置失败%' and ftype=0  
--音频文件加载失败
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,5 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype=1 and logmsg like '%音频文件加载失败%' and ftype=0   
--无法连接无线网络 
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,6 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype in (0,1) and logmsg like '%无法连接无线网络%' and ftype=0  
--无法连接互联网  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,7 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype in(0,1) and logmsg like '%ViewActivity无法连接到网络%' and ftype=0  
--系统时间不准  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,8 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype in (0,1) and logmsg like '%系统时间不准%' and ftype=0  
  
--界面跳转控制发生异常
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,9 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype in (0,1) and logmsg like '%界面跳转控制发生异常%' and ftype=0  
--照片加载出错  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,9 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype in (0,1) and logmsg like '%照片加载出错%' and ftype=0 
--公告信息已经过期  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,11 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=0 and devicetype in(0,1) and logmsg like '%公告信息已经过期%' and ftype=0  
  
--MU260机器连接失败  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,7,12 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where (logtype=27 or logtype=25)and devicetype=2 and ftype=0  

--磁盘空间不足  
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype,result)   
select logid,d.devicetype,8,1,cast(
			(case ISNUMERIC(REPLACE(REPLACE(logmsg,'Disk space ',''),'GB available','')) 
			 when 1 then REPLACE(REPLACE(logmsg,'Disk space ',''),'GB available','')
			else '0.0' end)
		 as float) result
 from mcapp..LogInfo l  
inner join mcapp..driveinfo d   
 on l.devid=d.devid    
where logtype=16 and devicetype in(0,1) and logmsg like '%Disk space%' and ftype=0  

--服务端错误
insert into @HAVE_MOVE(ID,devicetype,logtype,smalllogtype)   
select logid,d.devicetype,9,case when logtype=28 then 1 else 2 end
 from mcapp..LogInfo l  
  inner join mcapp..driveinfo d   
   on l.devid=d.devid    
 where logtype in(28,29) and ftype=0  

Begin tran     
 BEGIN TRY  
 
	--;with cet as(
	--	select * ,ROW_NUMBER()over(partition by id order by logtype,smalllogtype)rowno
	--	from @HAVE_MOVE
	--	)

	--select * from cet 
	-- where rowno>1   

	insert into loginfo_ex(devid,gunid,logtype,smalllogtype,logmsg,result,logtime,uploadtime,kid,devicetype)
	 select l.devid,l.gunid,m.logtype,m.smalllogtype,logmsg,m.result,logtime,uploadtime,kid,m.devicetype 
	 from loginfo l 
	  inner join @HAVE_MOVE m 
	   on l.logid=m.id

	update l
	 set ftype =1 
	 from loginfo l 
	  inner join @HAVE_MOVE m 
	   on l.logid=m.id 
	  
	Commit tran                                
 End Try        
 Begin Catch  
    select ERROR_LINE() as Line, 
	 ERROR_MESSAGE() as message1, 
	 ERROR_NUMBER() as number, 
	 ERROR_PROCEDURE() as proc1, 
	 ERROR_SEVERITY() as severity, 
	 ERROR_STATE() as state1   
    Rollback tran        
 end Catch   
 
end

GO
