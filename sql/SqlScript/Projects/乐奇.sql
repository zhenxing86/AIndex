--乐奇
以前已经购买过的
12511
dmzzzx(张博森)  (小班\中班\大班)

KID:2395
13380066335(蜘蛛侠)  (小班\中班) 60398

KID:5380
13602418503(胡孚瑞)  (中班\大班) 85029
13600094468(陈靖扬)	 (小班\大班) 85077


119063	13826460876	(KID:2625	郑桐)(大班) 
119433	13926270178 (KID:3482	王敬勋)(中班) 

select 
CommonFun.dbo.fn_RoleGet(lqRight,1),CommonFun.dbo.fn_RoleGet(lqRight,2),
CommonFun.dbo.fn_RoleGet(lqRight,3),CommonFun.dbo.fn_RoleGet(lqRight,4),
CommonFun.dbo.fn_RoleGet(lqRight,5),CommonFun.dbo.fn_RoleGet(lqRight,6)
,lqRight,* from BasicData..[user] 
where --kid=12511 and 
userid=626908   759920   --653612

select * from basicdata..[user] u where account ='13750992285'


select * from basicdata..[user] u where kid=12511 and userid = 295768 and account= 'jz1'
--新增权限
update u set lqRight=CommonFun.dbo.fn_RoleAdd(lqRight,5) 
from basicdata..[user] u where kid=12511 and userid=653612  --653612

--删除权限
update u set lqRight=CommonFun.dbo.fn_RoleDel(lqRight,5) 
from basicdata..[user] u where userid=626908 and kid=12511 and 


601206	jgey高浩宇	14910
601215	jgey黄瑞洋	14910
select* from BasicData..User_Child where userid =653612 
select * from gameapp..lq_game_mark where userid=653612
select * from  payapp..pay_record where userid=653612 
select * from payapp..user_pay_account where userid=653612
select * from gameapp..lq_paydetail where userid = 653612

select * from  payapp..order_record where userid=653612 

select* from PayApp..product 

select* from payapp..user_pay_account where userid= 295765  

insert into payapp..user_pay_account
select 653612,'','',50,250

update payapp..user_pay_account
 set re_beancount=170
where userid=653612


--乐奇数据转移脚本
gameapp
lq_data_transfer  --脚本

select distinct userid from gameapp..lq_paydetail    --777
select * from BasicData..[user] u  where u.LqRight is not null  --758
select userid from gameapp..lq_paydetail p  --1225
where not exists (
	select * from BasicData..[user] u 
	where p.userid=u.userid and u.LqRight is not null
)
order by userid

13750992285


                      

