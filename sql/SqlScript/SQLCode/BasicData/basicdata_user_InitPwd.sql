USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_InitPwd]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
CREATE PROCEDURE [dbo].[basicdata_user_InitPwd]       
@userid int 
,@douserid int =0   
AS    
     EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'Basicdata.dbo.basicdata_user_InitPwd' --设置上下文标志  
 update basicdata.dbo.[user] set [password]='7C4A8D09CA3762AF61E59520943DC26494F8941B' where userid=@userid    
     
 if(@@ERROR<>0)    
 begin    
  return (-1)    
 end    
 else    
 begin    
  return (1)    
 end     
    
    
GO
