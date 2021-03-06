USE [GameApp]
GO
/****** Object:  StoredProcedure [dbo].[lq_data_transfer]    Script Date: 2014/11/24 23:07:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*        
-- =============================================        
-- Author:  xie      
-- Create date: 2014-03-19        
-- Description: 乐奇数据（购买权限、购买记录）迁移 （从旧版转移到新版）   
-- Memo:  lq_data_transfer   
*/        
CREATE PROCEDURE [dbo].[lq_data_transfer]    
AS        
      
BEGIN        
 SET NOCOUNT ON        
 EXEC commonfun.dbo.SetDoInfo @DoUserID = 0, @DoProc = 'lq_data_transfer' --设置上下文标志        
 Begin tran           
 BEGIN TRY     
   
 --权限开通  
 --select * from gameapp..lq_paydetail  
  
 update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,1)   
  from basicdata..[user] u   
   inner join gameapp..lq_paydetail p on u.userid=p.userid and p.lq_gradeid=1  
  
 update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,2)   
  from basicdata..[user] u   
   inner join gameapp..lq_paydetail p on u.userid=p.userid and p.lq_gradeid=1  
  
 update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,3)   
  from basicdata..[user] u   
   inner join gameapp..lq_paydetail p on u.userid=p.userid and p.lq_gradeid=2  
  
 update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,4)   
  from basicdata..[user] u   
  inner join gameapp..lq_paydetail p on u.userid=p.userid and p.lq_gradeid=2  
  
 update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,5)   
  from basicdata..[user] u   
   inner join gameapp..lq_paydetail p on u.userid=p.userid and p.lq_gradeid=3  
  
 update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,6)   
  from basicdata..[user] u   
   inner join gameapp..lq_paydetail p on u.userid=p.userid and p.lq_gradeid=3  
  
    --购买记录转移       
 ;with cet as  
 (   
  select case when lq_gradeid=1 then 1 when lq_gradeid=2 then 3 when lq_gradeid=3 then 5 end lq_gradeid,  
   userid,'1' ftype,50 bean_count,10 plus_amount,paydate,1 deletetag  
  from gameapp..lq_paydetail  
  union all  
  select   
   case when lq_gradeid=1 then 2 when lq_gradeid=2 then 4 when lq_gradeid=3 then 6 end lq_gradeid,  
   userid,'1' ftype,50 bean_count, 10 plus_amount,paydate,1 deletetag  
  from gameapp..lq_paydetail  
 )  
   
 insert into payapp..order_record(userid,plus_amount,plus_bean,actiondatetime,orderno,[status],[from],PayType)  
  select userid,plus_amount,bean_count,paydate,'0000',1,cet.ftype,lq_gradeid from cet  
   where not exists(  
    select 1 from payapp..order_record p  
     where cet.userid = p.userid and cet.ftype=p.[from] and cet.lq_gradeid=p.PayType 
   )  

  Commit tran                                      
 End Try              
 Begin Catch              
  Rollback tran     
  print 'error'        
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志                   
 end Catch          
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志        
   print 'success'           
        
END        

--select COUNT(1) from payapp..order_record where [from] = '1'
GO
