USE [PayApp]
GO
/****** Object:  StoredProcedure [dbo].[PurchaseReadCard]    Script Date: 2014/11/24 23:23:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select * from basicdata..[user] where account='dmzzzx'
--select * from sbapp..readcard_pay where userid=381663

CREATE PROCEDURE [dbo].[PurchaseReadCard]
@userid int,
@period int,
@enddate datetime
 AS 
declare @curprice int
declare @bookprice int


if(@period=0)
begin
	set @bookprice=300	
end
else if(@period=1)
begin
	set @bookprice=500
end

if not exists(select * from sbapp..readcard_pay where userid=@userid and enddate>=GETDATE())
begin	
		update payapp..user_pay_account set 
		re_beancount=re_beancount-@bookprice
		where userid=@userid    


		INSERT INTO sbapp..readcard_pay(
		[userid],[period],[enddate]
		)VALUES(
		@userid,@period,@enddate
		)		

		Return 1
end

  Return 1




--update payapp..user_pay_account set re_beancount=1000 where userid=295765

--select * from sbapp..readcard_pay
--delete sbapp..readcard_pay
GO
