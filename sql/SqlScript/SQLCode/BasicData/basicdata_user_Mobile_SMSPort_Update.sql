USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_Mobile_SMSPort_Update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE PROCEDURE [dbo].[basicdata_user_Mobile_SMSPort_Update]      
@userid int,      
@smsport int,
@douserid int=0    
 AS       
  EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'Basicdata.dbo.basicdata_user_Mobile_SMSPort_Update' --设置上下文标志 
 update basicdata.dbo.user_baseinfo set smsport=@smsport      
  where userid=@userid    
 update basicdata.dbo.[user] set smsport=@smsport      
  where userid=@userid    

 EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志   
 if(@@ERROR<>0)      
 begin      
  return (-1)      
 end      
 else      
 begin      
  return (1)      
 end       
     
GO
