14979]济南大学幼儿园 @谢振兴 帮我导一下这个园2015-9-1到2016-1-1在线支付的明细，谢谢




;with cet as(
select u.userid,u.cname 班级,u.name 姓名,uf.crttime 缴费时间
 from payapp..user_fees uf
 inner join basicdata..[USER_child] u
  on uf.userid =u.userid 
  where u.kid=14979 and crttime>='2015-9-1' and crttime<='2016-1-1'
  --order by cname,u.name
 ),cet2 as(
select * from PayApp..sgs_pay_record r
where kid=14979 and status=1 and crtdate>='2015-8-1' and crtdate<='2016-1-20'
and exists(select * from PayApp..user_fees uf where
uf.kid=14979 and uf.userid=r.userid 
and uf.crttime>='2015-9-1' and uf.crttime<='2016-1-1')
and exists(select * from basicdata..[USER] u
  where r.userid =u.userid and kid=14979 )
 )
 select * from cet c where not exists(select * from cet2 c2 where c2.userid=c.userid)
  
select * from PayApp..sgs_pay_record where userid =1604573
    
select orderno,COUNT(orderno) from PayApp..sgs_pay_record 
where kid=14979 and crtdate>='2015-9-1' and crtdate<='2016-1-1'
group by kid,orderno
having COUNT(orderno)>1

--select userid,COUNT(userid) from PayApp..sgs_pay_record 
--where kid=14979 and crtdate>='2015-9-1' and crtdate<='2016-1-1' and status=1
--group by userid
--having COUNT(userid)>1

  
  select * from basicdata..[USER] u where userid in(610924,1435784,1580448,1580491,1580494,1580506,1580508,1601951)

select u.name 姓名,uf.crttime 缴费时间,u.cname 班级,uf.*
 from payapp..user_fees uf
 inner join basicdata..[USER_child] u
  on uf.userid =u.userid 
  where u.kid=31717 and crttime>='2016-7-1' and crttime<='2016-11-1'
  order by cname,u.name


select u.username 姓名,u.crtdate 缴费时间,u.tel 手机号,u.*
 from payapp..sgs_pay_record u
  where u.kid=31717 and crtdate>='2016-7-1' and crtdate<='2016-11-1'
   and status=1
---------------------------------------------------------------------


---------------------套餐有效时间确认-------------------------

select * from PayApp..fees where kid= 32833
select * from PayApp..fees where fee_name='幼儿健康服务包' kid= 0

select * from PayApp..user_fees where fee_id=141
select * from PayApp..user_fees where fee_id=144
select * from PayApp..user_fees where fee_id=135


select * 
--update a set ltime='2017-03-01 00:00:00.000' 
 from ossapp..addservice a where kid= 32833 and a1=1201 and ID<=1100362 order by id
select *
--update a set ltime='2017-03-01 00:00:00.000' 
from ossapp..addservice_status_log a where kid= 32833 and a1=1201 and ID<=445411 and status=1 order by id

--开通的套餐有效期有2个或者多于2个的幼儿园
;with cet as(
select kid,ltime from ossapp..addservice a 
where paytime>='2016-04-01' and describe='开通'
group by kid,ltime
--order by kid,ltime
)
select kid,COUNT(ltime) cnt,MAX(ltime) max_ltime,min(ltime) min_ltime
from cet 
group by kid
having COUNT(ltime)>1

select * from ossapp..addservice 
where kid=31689 and paytime>='2016-04-01' and describe='开通'

29312 探星幼儿园  健康服务缴费