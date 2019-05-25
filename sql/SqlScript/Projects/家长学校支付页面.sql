--家长学校支付页面

payapp

Create_Order
UpdateOrderStatus  '201403271514068145619' 
trg_order_record

select *from BasicData..[user]
where account='jz1' and userid = 653612             userid=216047 


--测试用户 653612  jz1

select * from order_record where userid  = 653612


ossapp
[app_feestandard_GetFeeInfo] 12511,191,  653612
  
select * from  ossapp..feestandard 
where kid = 12511 and uid=653612

app_feestandardLog_GetList 

ossapp..app_userpay_GetModel

--时光树统一支付接口
select * from PayApp..sgs_pay_record where crtdate>='2015-12-18' 
sgs_CreateOrder
select * from PayApp..trg_sgs_pay_record
select * from  user_fees where userid=862918
select * from PayApp..user_fees_log where userid=862918 and crtdate>='2015-12-18' 
delete from  user_fees where userid=862918 and 
select * from  fees where fee_id=11
update PayApp..sgs_pay_record set status=1 where orderid = 572


--套餐和费用绑定
select * from PayApp..fees where kid= 31062

insert into PayApp..fees([from],kid,fee_name,fee_des,expires,fee_money,deletetag,feetype)
select [from],31062,fee_name,fee_des,expires,fee_money,deletetag,feetype
 from PayApp..fees where kid= 28277 and fee_id=11
 
update PayApp..fees set fee_money=60 where fee_id=18