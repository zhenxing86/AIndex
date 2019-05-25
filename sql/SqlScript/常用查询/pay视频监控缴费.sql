use payapp
go

'13970838526'

select * from BasicData..User_Child where userid=2434033
--缴费状态
payapp..userfee_buytime_GetStatus @uid =2434033,@feetype =2   

------------------班级主页显示视频监控的入口-------------

basicdata..get_videomonitordesc

设置观看时间段：
select *  
--update k set video_monitor_desc='视频在线(看视频的时间是：上午9:00-11:00 ，下午14:30-16:30)'  
from basicdata..kindergarten k  
where kid=36912  and deletetag=1

配置好后，需要客服那边配置视频流，oss后台的站点管理，开通在线视频 勾选后，在班级主页可以观看在线视频,了解孩子在园情况
-------------------------------------------------------

--二维码支付  借阅服务费
http://payweixin.pc118.zgyey.com/sgspay/productvideo.aspx?kid=29096&userid=2103390
http://payweixin.zgyey.com/sgspay/productvideo.aspx?kid=29096&userid=2103390

select * from fees_buytime where kid=24082
select * from subfees_buytime where fee_id=3

'lilijz'

select * from mcapp.dbo.sms_man_kid where roletype = 5


--设置视频监控的有效期
Select f.fee_id,f.kid,f.feetype,f.fee_name,f.fee_des,f.pay_bgndate,f.pay_enddate,sf.subfee_id,  
         sf.subfee_name,sf.subfee_des,sf.fee_money,sf.expires,sf.expiresenddate,sf.expiresRemark  
--update sf set expiresenddate='2018-09-01'
--update f set pay_bgndate='2018-02-28 00:00:00.000',pay_enddate='2018-02-28 00:00:00.000'
   From fees_buytime f  
    inner join subfees_buytime sf  
     on f.fee_id=sf.fee_id   
      and f.deletetag=1  
      and sf.deletetag=1  
    Where f.feetype=2 and f.kid = 29096 and sf.expiresenddate='2018-08-01' 
    
declare @fee_id int
insert into fees_buytime(kid,feetype,fee_name,fee_des,pay_bgndate,pay_enddate)
 values(36912,2,'视频监控服务包','视频监控',GETDATE(),GETDATE())
set @fee_id=SCOPE_IDENTITY() 
insert into subfees_buytime(fee_id,subfee_name,subfee_des,fee_money,expires,expiresenddate,expiresRemark,deletetag)
 values(@fee_id,'一学期','',100,0,'2018-09-01','',1)

 
select * from payapp..fee_buytime_Order where kid=29096 and crtdate>='2018-03-01' and userid= 2230229 and status=1
select *
--update uf set deletetag=0
 from payapp..[userfee_buytime] uf where feetype=2  and userid=2103390


--fee_buytime_Order_UpdateStatus 1536233,'TPay2201609240942529558785',1,'123'  

select *
--update c set url='http://sgs.pay.zgyey.com/tpay/index?kid={kid}&client={client}&appver={appver}&uid={uid}&feetype=2'
 from kmapp..Custom_Package c where ptype=117 and deletetag=1 and kid=20675
 
insert into kmapp..Custom_Package(kid,ptype,title,url,deletetag)
select 31996,ptype,'视频监控套餐','http://sgs.pay.zgyey.com/tpay/index?kid={kid}&client={client}&appver={appver}&uid={uid}&feetype=2',1
 from kmapp..Custom_Package where ptype=117 and deletetag=1 and ID=13


然后利息是 一个月 

select 40*8
select 80000/12

--视频缴费人数
  select kid,COUNT(1) 缴费人数,sum(fee_money) 金额
 from payapp..fee_buytime_Order uf
  where uf.kid in(31996,1695,31592,20938,5662,33124,6748,33132,36021,36912) and uf.crtdate>='2018-07-24'
   --and uf.crtdate<='2018-07-24' 
   and uf.status=1
  group by uf.kid
  
--微信支付没有绑定用户的
  select case when u.kid=0 then '离园' else '' end  状态 ,isnull(c.cname,uf.tel) 班级,isnull(u.name,uf.username) 姓名,uf.crtdate 缴费时间,uf.*
 from payapp..fee_buytime_Order uf
 left join basicdata..[USER] u
  on uf.userid =u.userid 
 left join BasicData..user_class uc
  on u.userid = uc.userid
 left join basicdata..class c on c.cid=uc.cid
  where uf.kid=29048 and uf.crtdate>='2016-3-1'
   and uf.crtdate<='2016-11-1' and uf.status=1
  order by cname,u.name
  
  
  
--清除之前学期的缴费记录
select * 
--update uf set deletetag=0
from payapp..user_fees uf
 where kid=35182 and enddate<='2017-03-01'

--缴费次数
select ub.userid,COUNT(1) 
from userfee_buytime ub
inner join fee_buytime_Order uf on ub.userid=uf.userid and ub.orderno=uf.orderno
 and uf.crtdate>='2018-1-1'
 and uf.status=1 and uf.feetype=2
 group by ub.userid
 having COUNT(1)>1

--重复缴费视频监控的用户
select uc.kid,k.kname,uc.name username, uc.cname,o.* from fee_buytime_Order o 
 inner join basicdata..user_child uc on o.userid=uc.userid
 inner join BasicData..kindergarten k on k.kid=uc.kid 
  where o.userid in(2334775,2425450,2426889) and feetype=2 and status=1 and o.crtdate>='2018-01-01' order by o.userid,orderid

--修改用户的套餐有效期
select *
--update ub set enddate='2018-09-01 00:00:00.000'
from userfee_buytime ub
inner join fee_buytime_Order uf on ub.userid=uf.userid and ub.orderno=uf.orderno
 and uf.crtdate>='2018-1-1'
 and uf.status=1 and uf.feetype=2
 
select *
 from payapp..fee_buytime_Order uf
  where uf.crtdate>='2018-1-1'
   --and uf.crtdate<='2016-11-1' 
   and uf.status=1 and uf.feetype=2
  

--幼儿园缴费人数
  select kid,COUNT(1) 缴费人数
 from payapp..fee_buytime_Order uf
  where uf.crtdate>='2018-1-1'
   --and uf.crtdate<='2016-11-1' 
   and uf.status=1 and uf.feetype=2
  group by uf.kid


------------------------------Start 健康服务包--------------------------------
declare @fee_id int
insert into fees_buytime(kid,feetype,fee_name,fee_des,pay_bgndate,pay_enddate)
 values(30624,1,'健康服务包','健康',GETDATE(),GETDATE())
set @fee_id=SCOPE_IDENTITY()

insert into subfees_buytime(fee_id,subfee_name,subfee_des,fee_money,expires,expiresenddate,expiresRemark,deletetag)
 values(@fee_id,'6个月','',80,6,'2010-01-01','',1)
insert into subfees_buytime(fee_id,subfee_name,subfee_des,fee_money,expires,expiresenddate,expiresRemark,deletetag)
 values(@fee_id,'1年','减10元',150,12,'2010-01-01','',1) 
insert into subfees_buytime(fee_id,subfee_name,subfee_des,fee_money,expires,expiresenddate,expiresRemark,deletetag)
 values(@fee_id,'2年','减40元',280,24,'2010-01-01','',1)
insert into subfees_buytime(fee_id,subfee_name,subfee_des,fee_money,expires,expiresenddate,expiresRemark,deletetag)
 values(@fee_id,'3年','减100元',380,36,'2010-01-01','',1)
 
------------------------------------End 健康服务包-----------------------------------

------------------------------Start更新有效期----------------------------------------
declare @enddate datetime,@date datetime=getdate()
set @enddate= case when DATEPART(m,@date)=1 then CONVERT(varchar(4), @date,120) +'-09-01' else CONVERT(varchar(4), dateadd(YEAR,1,@date),120) +'-03-01' end
select *
    --update sf set expiresenddate= @enddate  
     From payapp..fees_buytime f    
      inner join payapp..subfees_buytime sf    
       on f.fee_id=sf.fee_id     
        and f.deletetag=1    
        and sf.deletetag=1    
     Where f.feetype=2 and sf.expiresenddate<=@enddate 
------------------------------End更新有效期--------------------------------- 