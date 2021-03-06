USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[varify_SendVerifyCode]    Script Date: 2014/11/24 21:18:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:  xzx  
-- Project: com.zgyey.verify  
-- Create date: 2013-06-05  
-- Description: 发送验证码  
--[varify_SendVerifyCode] 'jz1','18028633611','123456',2  
-- =============================================  
CREATE PROCEDURE [dbo].[varify_SendVerifyCode]  
@account nvarchar(50),  
@mobile nvarchar(20),  
@code nvarchar(20),  
@ftype int = 0    -- 0:密码找回项目，1：家长学校激活卡，2：手机客户端  
AS  
declare   
@updateTime datetime,  
@verifyCount int,  
@smscontent nvarchar(200),  
@ret varchar(10),  
@userid int  
BEGIN  
 if(@ftype=0)  
  set @smscontent = '您好!您在幼儿园云服务平台申请找回密码的验证码是['+@code+'],该验证码2分钟内有效，请及时验证。'  
 else if(@ftype=1)  
  set @smscontent = '您好!您的家长学校激活卡验证码是['+@code+'],该验证码2分钟内有效，请及时验证。'  
 else set @smscontent = '您好!您在幼儿园云服务平台申请找回密码的验证码是['+@code+'],该验证码2分钟内有效，请及时验证。'   
 if exists(   
   select 1 from verify    
     where account = @account   
     and mobile = @mobile  
     and datediff(day,verify_time,getdate())=0  
    )  
  begin  
  select @updateTime =update_time,@verifyCount=verify_count from verify    
    where account = @account   
    and mobile = @mobile  
       and datediff(day,verify_time,getdate())=0  
         
  if ( datediff(SS,@updateTime,getdate()) <300 ) --2分钟验证一次  
  begin  
   set @ret = '-2'  
  end  
  else if ( @verifyCount>=3 )  
  begin  
   update verify set verify_count=verify_count+1  
     where account = @account and mobile = @mobile  
     and datediff(day,verify_time,getdate())=0  
   set @ret = '-3'  
  end  
  else  
  begin  
   update verify set verify_code = @code,verify_count=verify_count+1,  
   update_time = getdate()  
   where account = @account and mobile = @mobile  
   and datediff(day,verify_time,getdate())=0  
     
     
     
     
   insert into verify_sms(account,mobile,verify_code,verify_time)  
     values(@account,@mobile,@smscontent,getdate())  
   set @ret = '1'  
  end  
  end   
  else  
  begin  
   insert into verify(account,mobile,verify_code,verify_count,verify_time,update_time)  
   values(@account,@mobile,@code,1,getdate(),getdate())  
  insert into verify_sms(account,mobile,verify_code,verify_time)  
  values(@account,@mobile,@smscontent,getdate())  
  set @ret = '1'  
  end  
    
  select @userid =userid  
   from BasicData..[user]    
    where account = @account     
    and deletetag = 1    
       
 select @ret,@userid  
    
END  
GO
