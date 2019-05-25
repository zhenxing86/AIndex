USE [PayAppDemo]
GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 2014/11/24 23:24:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







--select * from user_pay_account
--select * from order_record where orderno='20111109212228'
--delete user_pay_account where userid=216047
--[UpdateOrderStatus] '20111109212228'
CREATE PROCEDURE [dbo].[UpdateOrderStatus]
@orderno nvarchar(50)
 AS 



	if exists(select * from order_record where orderno=@orderno and status=0)
	begin
		update order_record set status=1 where orderno=@orderno and status=0
	
	
		declare @userid int
		declare @plus_amount int
		declare @plus_bean int
		select @userid=userid,@plus_amount=plus_amount from order_record where orderno=@orderno and status=1

		set @plus_bean = @plus_amount*5
		if(@plus_amount=50)
		begin
			set @plus_bean = @plus_bean+30	
		end
		if(@userid>0)
		begin
			if exists(select * from user_pay_account where userid=@userid)
			begin
				update user_pay_account set re_amount=re_amount+@plus_amount,
				re_beancount=re_beancount+@plus_bean
				where userid=@userid    
				insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)values('18028633611',5,'^_^续充值^_^!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);
				insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)values('13808828988',5,'^_^续充值^_^!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);

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
--				declare @plus_amount int
--				set @plus_amount=20
				insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)values('18028633611',5,'^_^有用户充值智慧豆成功!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);
				insert into sms..sms_message(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)values('13808828988',5,'^_^有用户充值智慧豆成功!金额'+Convert(nvarchar(20),@plus_amount),getdate(),18,88,getdate(),0,0);
			end
		end

	end
	else
	begin
		return 0
	end

	  IF @@ERROR<>0
	  BEGIN  
		RETURN 0
	  END
	  ELSE
	  BEGIN  
		Return 1
	  END








GO
