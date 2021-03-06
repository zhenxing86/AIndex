USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[basicdata_user_SName_Update]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*          
-- Author:      xie          
-- Create date: 2014-07-23          
-- Description:   修改生僻字替代名称       
-- Memo:            
exec basicdata_user_SName_Update  295765,'特使'       
*/    
    
CREATE PROCEDURE [dbo].[basicdata_user_SName_Update]        
@userid int,        
@sname nvarchar(50)  
,@douserid int=0
 AS       
 
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @douserid, @DoProc = 'Basicdata.dbo.basicdata_user_SName_Update' --设置上下文标志   
 update basicdata.dbo.[user]   
  set sname=@sname  
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
