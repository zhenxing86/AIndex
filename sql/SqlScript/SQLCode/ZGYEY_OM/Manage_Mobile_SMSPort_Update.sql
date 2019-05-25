USE [ZGYEY_OM]
GO
/****** Object:  StoredProcedure [dbo].[Manage_Mobile_SMSPort_Update]    Script Date: 2014/11/24 23:30:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Manage_Mobile_SMSPort_Update]  
@userid int,  
@smsport int  
 AS   
 update basicdata.dbo.user_baseinfo set smsport=@smsport  
  where userid=@userid
 update basicdata.dbo.[user] set smsport=@smsport  
  where userid=@userid
  
 if(@@ERROR<>0)  
 begin  
  return (-1)  
 end  
 else  
 begin  
  return (1)  
 end   
 

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'短信通道修改' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Manage_Mobile_SMSPort_Update'
GO
