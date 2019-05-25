    
    
    
declare @kid int=20675,@pid int,@a1 int=0,@intime datetime=getdate(),@a3 int=0,@a9 int =0,@feetype int =2,@fee_name nvarchar(50)='健康服务包',@fee_money int=50
select @pid = isnull(id,0) from ossapp.[dbo].[feestandard] where kid=@kid and describe =@fee_name and remark='SGS PAY' and deletetag=1

if @pid=0
begin
	select @a3 = (case when @feetype=1 then 802 else 0 end),@a9=case when @feetype=2 then 808 else 0 end
	exec @pid = ossapp.[dbo].[feestandard_ADD] @kid =@kid,@sname ='',@describe =@fee_name,@price =@fee_money,  
		@isproxy =0,@proxyprice =@fee_money,@isinvoice =0,@uid =134,@intime =@intime,@a1 =500, @a2 =0, @a3 = @a3,  
		@a4=0,@a5=0,@a6=0,@a7=0,@a8=0,@remark='SGS PAY',@deletetag=1,@a9=@a9, @a10=0,@a11=0,@a12=0,@a13=0
end

select @pid	
			 
			 
select * from ossapp.[dbo].[feestandard] where kid =26444
select *  from ossapp.[dbo].[feestandard] where kid =23967 and ID=1154
select * from fees where kid =23967
select * delete from user_fees where userid=862914
select * from user_fees_log where userid=862914

select * from sgs_pay_record where userid=862914 and crtdate>='2015-11-09'

select u.kid,u.name,r.* 
-- delete r
from payapp..user_fees r
 inner join BasicData..[USER] u
  on r.userid= u.userid
   where u.kid=23967 and [from]='sgs' 
   
select *  from user_fees where kid=29312
   
select r.* 
--update r set feetype=2
from fees r where fee_name='幼儿成长档案VIP服务费'

payapp..sgs_GetUserFeeInfo
   

select * from  fees where kid=28277   --29312

select * from  fees where kid=29312 and fee_id=128

http://sgs.pay.zgyey.com/pay/index?kid={kid}&client={client}&appver={appver}&uid={uid}&hxuid={hxuid}&role={role}
http://sgs.pay.zgyey.com/pay/index?kid=23967&client=2&appver=3.1&uid=862914&hxuid=862914a0&role=2




