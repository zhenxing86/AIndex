/*    
-- =============================================    
-- Author:  Master谭    
-- Create date: 2014-02-12    
-- Description: 在线支付订单成功支付后调用    
-- Memo:    
 UpdateOrderStatus '201412261005499597305'
*/    
alter PROCEDURE [dbo].[UpdateOrderStatus]    
 @orderno nvarchar(50)    
 AS     
BEGIN    
 SET NOCOUNT ON;     
 declare @userid int    
 declare @plus_amount int    
 declare @plus_bean int    
 IF exists(select * from order_record where orderno = @orderno and [from] = '809')    
 BEGIN    
  update order_record     
   set status=1     
    where orderno=@orderno     
     and status = 0     
     and [from] = '809'         
      
   select @plus_amount=plus_amount from order_record where orderno=@orderno and status=1    
   insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)    
    values('18028633611',0,'订单['+@orderno+']支付亲子阅读！金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);    
  return 1    
 END    
 else IF exists(select * from order_record where orderno = @orderno and [from] = '10000')    
 BEGIN    
  update order_record     
   set status=1     
    where orderno=@orderno     
     and status = 0     
     and [from] = '10000'         
      
   select @plus_amount=plus_amount from order_record where orderno=@orderno and status=1    
   insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)    
    values('18028633611',0,'订单['+@orderno+']支付创典家长学校业务！金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);       
  return 1    
 END    
 else IF exists(select * from order_record where orderno = @orderno and [from] = '10001')      
 BEGIN      
  update order_record       
   set status=1       
    where orderno=@orderno       
     and status = 0       
     and [from] = '10001'           
        
   select @plus_amount=plus_amount from order_record where orderno=@orderno and status=1      
   insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)      
    values('18028633611',0,'支付原生态贝睿绘本业务！金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);        
  return 1      
 END 
    
 if exists(select * from order_record where orderno=@orderno and status=0)    
 begin    
  Begin tran       
  BEGIN TRY      
   update order_record set status=1 where orderno=@orderno and status=0    
    
   select @userid=userid,@plus_amount=plus_amount from order_record where orderno=@orderno and status=1    
    
   set @plus_bean = @plus_amount*5    
   if(@plus_amount=60)    
   begin    
    set @plus_bean = @plus_bean+50     
   end    
   else if(@plus_amount=100)    
   begin    
    set @plus_bean= @plus_bean+100    
   end    
   if(@userid>0)    
   begin    
    if exists(select * from user_pay_account where userid=@userid)    
    begin    
     update user_pay_account set re_amount=re_amount+@plus_amount,    
     re_beancount=re_beancount+@plus_bean    
     where userid=@userid        
     insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)    
      values('18028633611',0,'订单['+@orderno+']^_^续充值^_^!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);    
     insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)    
      values('13808828988',0,'订单['+@orderno+']^_^续充值^_^!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);    
    end    
    else    
    begin    
     INSERT INTO user_pay_account (     
     [userid] ,    
     [pay_pwd] ,    
     [bind_mobile] ,    
     [re_amount] ,    
     [re_beancount] )     
     values(@userid,'','',@plus_amount,@plus_bean)    
     insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)    
      values('18028633611',0,'订单['+@orderno+']^_^有用户充值智慧豆成功!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);    
     insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)    
      values('13808828988',0,'订单['+@orderno+']^_^有用户充值智慧豆成功!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);    
    end    
   end    
   Commit tran                                  
  End Try          
  Begin Catch          
   Rollback tran       
   Return  0          
  end Catch      
 end    
 else    
 begin    
  return 0    
 end    
 Return 1    
END 