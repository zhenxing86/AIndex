USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[Create_Order]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- =============================================    
-- Author:  Master谭    
-- Create date: 2014-02-12    
-- Description: 生成订单    
-- Memo:     
*/    
CREATE PROCEDURE [dbo].[Create_Order]    
 @userid int,    
 @plusamount int = null,    
 @plus_bean int = null,    
 @orderno nvarchar(50) = null,    
 @status int = 0,    
 @from nvarchar(50) = NULL,    
 @PayType int = 0,  
 @termtype int = 0    
AS    
BEGIN    
 SET NOCOUNT ON    
 EXEC commonfun.dbo.SetDoInfo @DoUserID = @userid, @DoProc = 'Create_Order' --设置上下文标志    
 DECLARE @orderid int    
 Begin tran       
 BEGIN TRY      
  INSERT INTO order_record(userid, plus_amount, plus_bean, actiondatetime, orderno, status, [from],PayType,termtype)    
   VALUES(@userid,@plusamount,@plus_bean,getdate(),@orderno,@status,@from,@PayType,@termtype)    
  SET @orderid = ident_current('order_record')     
  IF @from = '809' AND @PayType = 1    
  BEGIN    
   INSERT INTO sbapp..EnterRead(UserID, Kid, Name)    
    select UserID, Kid, Name     
     FROM BasicData..[user]    
      WHERE userid = @userid    
  END   
  ELSE IF @from = '1'   
  BEGIN    
     if exists (select 1 from product where ftype =1 and termtype= @termtype) --乐奇家园  
     begin--扣智慧豆      
   UPDATE PAYAPP..user_pay_account       
    SET re_beancount=re_beancount-@plus_bean,      
     re_amount = re_amount-@plusamount      
    where userid =@userId       
        
   --更新订单为支付完成状态  
   update order_record set status = 1 where orderid= @orderid  
        
   --开通权限 @termtype（1：小班上，2：小班下，3：中班上，4：中班下，5：大班上，6：大班下）     
   update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,@termtype)       
    from basicdata..[user] u where userid=@userid     
 end   
 else set @orderid = 0 -- 支付失败  
  END  
    
  Commit tran                                  
 End Try          
 Begin Catch          
  Rollback tran       
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志         
  Return 0          
 end Catch      
  EXEC CommonFun.dbo.sp_TrgSignal_Clear @pos = 1;  -------清除上下文标志         
 Return @orderid    
    
END 
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'支付方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'Create_Order', @level2type=N'PARAMETER',@level2name=N'@PayType'
GO
