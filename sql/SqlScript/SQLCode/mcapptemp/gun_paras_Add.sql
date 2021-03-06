USE [mcapptemp]
GO
/****** Object:  StoredProcedure [dbo].[gun_paras_Add]    Script Date: 2014/11/24 23:19:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
-- =============================================  
/*  
-- Author:  xzx  
-- Project: com.zgyey.ossapp  
-- Create date: 2013-09-24  
-- Description: 新增晨检枪参数(查询、修改)信息,新增一条新纪录前，先将旧的未执行指令作废  
-- Memo:  
 exec gun_paras_Add  
  @serial_no  ='00000000'  
  ,@kid   =12511  
  ,@devid   ='001251100'  
  ,@paras   ='01,02,03,04,05,06,07,08,09,0A,0B,0C,0D,0E,10,11,12,13,14,15,16,17,18,19,1A'  
  ,@paras_values  =''  
  ,@adate   ='2013-10-11 10:00:00'  
  ,@status  ='0'  
  ,@ftype   ='0'  
  
*/  
-- =============================================  
CREATE PROCEDURE [dbo].[gun_paras_Add]  
@serial_no varchar(20)  
,@kid int  
,@devid varchar(20)  
,@paras varchar(200)  
,@paras_values varchar(500)  
,@adate DateTime  
,@status int   
,@ftype int  
AS  
BEGIN  
  
if @ftype=0  
begin  
 update mcapp..gun_para_cx   
  set [status]=-1   
  where kid = @kid   
  and devid = @devid   
  and serial_no = @serial_no   
  and status<>2  
  
 insert into mcapp..gun_para_cx([kid],serial_no,devid,paras,paras_values,adate,[status])  
  values(@kid,@serial_no,@devid,@paras,@paras_values,@adate,@status)  
   
end  
else  
begin  
 update mcapp..gun_para_xg   
  set [status]=-1   
  where kid = @kid   
  and devid = @devid   
  and serial_no = @serial_no   
  and status<>2  
    
 insert into mcapp..gun_para_xg([kid],serial_no,devid,paras,paras_values,adate,[status])  
  values(@kid,@serial_no,@devid,@paras,@paras_values,@adate,@status)  
end   
END  
GO
