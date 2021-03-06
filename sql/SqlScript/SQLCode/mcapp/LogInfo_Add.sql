USE [mcapp]
GO
/****** Object:  StoredProcedure [dbo].[LogInfo_Add]    Script Date: 2014/11/24 23:15:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*              
-- Author:      xie       
-- Create date: 2014-07-04              
-- Description: 新增日志              
-- Memo:    
1=采集红外枪的晨检记录的数量,2=同步学生资料条数,3=同步教师资料条数,4=上传晨检记录条数,5=上传出勤记录条数(改为上传老师/学生更新信息)，
6=加载读卡器成功，7= 开卡成功，8=上位机网络连接异常，9= 与红外枪通信异常，10=版本更新失败，11=接口调用失败，12=加载读卡器失败，
13=刷卡失败，14= 开卡失败，15=卡验证失败，16=访问access失败，17=上传pc端数据失败，18=其他，19=同步晨检枪参数（查询/修改），
20=同步晨检枪参数（查询）出错，21=同步卡信息，22=同步晨检枪默认查询参数，23=一体机提示未登记卡，25=同步MU260设备信息，
26=MU260出错信息，27=同MU266设备连接状态,28=服务端操作数据失败，29=服务端解析json失败
 
  select* from mcapp..LogInfo
  where kid =12511
              
[LogInfo_Add] 12511,'001251100',
*/              
--              
create PROC [dbo].[LogInfo_Add]              
 @kid int              
,@devid nvarchar(50)
,@logtype int
,@logmsg nvarchar(4000)
AS              
BEGIN  

	insert into LogInfo(kid,devid,logtype,logmsg,logtime,uploadtime,ftype)
	 select @kid,@devid,@logtype,@logmsg,GETDATE(),GETDATE(),0   
	 
	if @@ERROR<>0
	  return -1
	else return 1
END	 

GO
