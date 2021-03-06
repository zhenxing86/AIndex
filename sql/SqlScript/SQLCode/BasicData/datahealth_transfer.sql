USE [BasicData]
GO
/****** Object:  StoredProcedure [dbo].[datahealth_transfer]    Script Date: 2014/11/24 21:18:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*            
-- =============================================            
-- Author:  xie          
-- Create date: 2014-04-15            
-- Description: 用户(学生/老师)离园数据迁移   
-- Memo:  datahealth_transfer      
  
存在问题：   
leave_kindergarten 存在重复记录。这个要问清楚为什么会出现重复。  
  
*/            
CREATE PROCEDURE [dbo].[datahealth_transfer]        
AS            
          
BEGIN            
 SET NOCOUNT ON            
 EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'datahealth_transfer' --设置上下文标志            
 Begin tran               
 BEGIN TRY    
 ;with cet as(  
 select userid,kid,MAX(actiondatetime) actiondatetime from user_kindergarten_history  
 group by userid,kid  
 )  
 insert into leave_kindergarten(userid,kid,outtime)  
  select userid,kid,actiondatetime from cet  
   where not exists(  
    select 1 from leave_kindergarten lk where cet.userid=lk.userid  
   )  
     
   --删除leave_kindergarten表中重复的数据      
   Delete a   
  From BasicData.dbo.leave_kindergarten a   
  Where Exists (  
   Select * From BasicData.dbo.leave_kindergarten b   
    Where a.userid = b.userid and a.cid = b.cid   
    Group by b.userid, b.cid  
    Having a.ID <> MAX(b.ID))  
       
 --注意，以前离园的老师没有记录。     
 insert into leave_user_class(userid,cid,actiondatetime)  
  select userid,cid,outtime from leave_kindergarten lk  
   where not exists(  
    select 1 from leave_user_class uch where uch.userid=lk.userid  
   ) and lk.cid is not null  
  print 'success'       
  Commit tran                                          
 End Try                  
 Begin Catch                  
  Rollback tran         
  print 'error'            
 end Catch              
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志            
             
            
END            
   
GO
