--购买记录
--select  top 10* from gameapp..lq_paydetail
--select  top 10 * from payapp..pay_record

;with cet as
( 
	select --case when lq_gradeid=1 then 1 when lq_gradeid=2 then 3 when lq_gradeid=3 then 5 end lq_gradeid,
	userid,1 ftype,50 bean_count,
	 case when lq_gradeid=1 then '乐奇家园(小班上学期)' 
	 when lq_gradeid=2 then '乐奇家园(中班上学期)' 
	 when lq_gradeid=3 then '乐奇家园(大班上学期)' end title,
	 paydate,1 deletetag
	from gameapp..lq_paydetail
	union all
	select 
	 --case when lq_gradeid=1 then 2 when lq_gradeid=2 then 4 when lq_gradeid=3 then 6 end lq_gradeid,
	  userid,1 ftype,50 bean_count,
	 case when lq_gradeid=1 then '乐奇家园(小班下学期)' 
	 when lq_gradeid=2 then '乐奇家园(中班下学期)' 
	 when lq_gradeid=3 then '乐奇家园(大班下学期)' end,
	 paydate,1 deletetag
	from gameapp..lq_paydetail
)
insert into payapp..pay_record(userid,ftype,bean_count,title,order_date,deletetag)
select userid,ftype,bean_count,title,paydate,deletetag from cet
 where not exists(
  select 1 from payapp..pay_record p
   where cet.userid = p.userid and cet.title=p.title
  )
  

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

blogapp

lq_data_transfer