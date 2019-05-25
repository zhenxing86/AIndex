use payapp
go

-------------在线缴费记录-------------
select uc.cname,uc.account,uc.userid,uc.name,case when PayType=1 then '支付宝' else '微信' end PayType,crtdate,*
--select uc.cname,uc.name,crtdate
from payapp..sgs_pay_record s 
 inner join BasicData..user_child uc on s.userid=uc.userid
where s.kid=34357 and crtdate>='2018-09-01' and s.status=1 and name='詹梓宁'



-----------------------------------------【公众号扫描支付借阅服务费START】-----------------------------------------------------
--二维码支付  借阅服务费
http://payweixin.pc118.zgyey.com/sgspay/productPagev5.aspx?kid=37585

1.37585 勒流胜利幼儿园
2.2018年9月19日-2018年9月30日
3.借阅有效期是2019年2月10日
4.费用是150元/学期 @谢振兴 小谢麻烦制作一个二维码谢谢啦

[34357]广州市黄埔区中大附属外国语实验幼儿园
1.麻烦开通一下这家园的在线缴费；2.缴费金额：250元/学期；3.本次缴费的服务有效期为：从缴费当日至2019年7月1日


--1) 设置金额和有效期
--expirestype  0按自然月，1：按具体时间， 2是无期限，一次性缴费
insert into payapp..fees([from],kid,fee_name,fee_des,expires,fee_money,deletetag,feetype,expirestype,expiresremark,expiresenddate,fee_kid,pay_bgndate,pay_enddate)
values('WX_JSAPI',0,'爱童书悦读馆的借阅服务费','',4,150,1,4,0,'一学期','2019-02-10 23:59:59',37585,'2018-09-19','2018-10-30')

select * 
--update f set deletetag=0
--update f set expirestype=0,fee_name='爱童书悦读馆的借阅服务费（150元）及健康服务费（100元）',fee_des='',expiresremark='一学期',fee_money=250,expiresenddate='2019-07-01 23:59:59',pay_bgndate='2018-09-14',pay_enddate='2018-09-14'
--update f set expirestype=0,fee_name='爱童书悦读馆的借阅服务费',fee_des='',expiresremark='一学期',fee_money=250,expiresenddate='2019-01-20 23:59:59',pay_bgndate='2018-09-14',pay_enddate='2018-09-20'
from payapp..fees f where fee_kid=34357

--2）在oss后台的套餐设置，绑定阅读，同时设置金额和有效期

select * from ossapp..feestandard where kid=20581 

--自动开通vip 操作记录
select * from ossapp..addservice_vip_Add_auto_update_log l
 inner join ossapp..users u on l.douserid=u.id where kid=20581
 
select * from payapp..sgs_pay_record where kid=20581 and crtdate>='2018-07-04'
select * from payapp..user_fees where kid=20581 and crttime>='2018-07-04'
select * from payapp..fees where feetype=4 kid=20581 and crttime>='2018-07-04'

select * from payapp..user_open_record where kid=20581 and crtdate>='2018-07-04'

select *       
 from ossapp.dbo.feestandard f                         
inner join [PayApp].[dbo].[fees] s on s.fee_id=f.sgsfeeid and s.deletetag=1 and s.kid=f.kid and s.[from]='ATS' and feetype=3                       
where f.kid=20581 and f.deletetag=1 

--PayApp.[dbo].payapp_fees_Save     


-------借阅服务，有效期设置（将 '2018-03-01' 改为 '2018-09-01'）------
select * 
--update s set expiresenddate='2018-09-01 00:00:00.000'
from ossapp..read_set where kid=28277

select * 
--update f set expiresenddate='2018-09-01'
from ossapp..feestandard fd inner join payapp..fees f on fd.sgsfeeid=f.fee_id and f.feetype=3   
where f.expiresenddate='2018-03-01'

select * 
--update rs set expiresenddate='2018-09-01'
from ossapp..read_set rs inner join ossapp..feestandard fd on rs.feeid=fd.ID   
where rs.expiresenddate='2018-03-01'



 
-----------------------------------------【公众号扫描支付借阅服务费END】-----------------------------------------------------

select * from BasicData..User_Child where kid=28277 and name like '%谢%'




--------------------------------------家园服务费-----------------------------------------------------
--http://payweixin.pc118.zgyey.com/sgspay/productPagev8.aspx?kid=23713&feetype=6
--payapp..sgs_fees_GetModelEx @kid=23736,@feetype=6  
--1) 在oss后台————客户收费——套餐设置——绑定：平台服务费   （已经集成修改描述，不过如果要自定义内容，则要 第二步修改）
--2）修改描述
update f set html_remark=N'<div>
        	<p class="text-a1">'+k.kname+'与国内最专业的幼儿互动教育平台--中国幼儿园门户网进行合作，为家长提供如下服务：</p>
            <p><img src="/Content/images/a1.jpg"/></p>
            <p class="text-a1">由于发送家园短信、使用成长档案、购买课件资源等各项服务直接成本及人员成本的存在，家长使用上述服务，需要向中国幼儿园门户网支付<span style="color:#E70003">'
            +CAST(f.fee_money as varchar)+'元/'+f.expiresRemark
            +'</span>的成本服务费用，希望各位家长给予理解和支持</p>
        	'--<p class="text-a1" style="color:#E70003"><strong>缴费时间：</strong>10月13—14日（周五、周六）</p>
        +'</div>'
--select *
from payapp..fees f inner join BasicData..kindergarten k on f.kid=k.kid
where f.kid=23713

--如果后期修改套餐有效期，直接在oss后台修改即可



-------------------------------------VIP 缴费时间有问题----------------------------------------------

select * from ossapp..users where id=132  --165 --148
select * from PayApp..user_fees where  enddate='2017-03-01' and crttime>='2017-01-01' 
select * from ossapp..addservice where ltime='2017-03-01' and dotime>='2017-01-01' and describe='开通'
select * from ossapp..addservice_status_log where kid=14979 and userid=2157820

---------------------------------------vip时间修改------------------------------
select * 
--update uf set enddate='2017-09-01'
from PayApp..user_fees uf where enddate='2017-03-01' and crttime>='2017-01-01' and kid=14979

select * 
--update uf set enddate='2017-09-01'
from PayApp..sgs_pay_record uf where enddate='2017-03-01' and crtdate>='2017-01-01' and status=1 and kid=14979

select * 
--update a set ltime='2017-09-01'
from ossapp..addservice a where ltime='2017-03-01' and dotime>='2017-01-01' and describe='开通' and kid=14979


payapp..sgs_GetUserFeeInfo 653612,'sgs'
payapp..sgs_GetUserFeeInfo 2337886,'ats'      
    
----------------------------缴费，没开vip记录查询------------------------
select k.kname,r.kid,uc.cname,uc.userid,uc.name username,r.crtdate,enddate,r.fee_id,r.fee_name
--select *
--select count(1)
 from PayApp..sgs_pay_record r
inner join BasicData..kindergarten k on k.kid=r.kid
inner join BasicData..User_Child uc on r.userid=uc.userid
where  r.crtdate>='2016-07-01' and r.status=1 and r.userid>0
and not exists(select 1 from ossapp..addservice a where a.uid=r.userid and
a.deletetag=1 and a.describe='开通' and ltime>'2016-09-01') --  and r.userid=1580500
order by r.kid,uc.cname,uc.name

select * from ossapp..addservice where uid in (1580500)
--------------------------------------------------------------------

--购买晨检卡
select * from payapp..[sgs_pay_record] where fee_id=153
select userid,COUNT(1) from payapp..[sgs_pay_record] where feetype=5 and kid=403 and status=1 
group by userid 
having COUNT(1)>1

select  uc.userid,uc.cname,uc.account,uc.name,r.orderno,r.crtdate,ROW_NUMBER() over( PARTITION by uc.userid order by uc.userid) rows
 from payapp..[sgs_pay_record] r
inner join BasicData..User_Child uc on r.userid=uc.userid
 where r.kid=25294 and status=1
 order by uc.userid
 
--班级，姓名，缴费时间，
select u.cname 班级,u.name 姓名,uf.crttime 缴费时间 from payapp..user_fees uf
 inner join basicdata..[USER_child] u
  on uf.userid =u.userid 
  where u.kid=14979
  order by cname,u.name

select c.cname 班级,u.name 姓名,uf.crttime 缴费时间,uf.*
 from payapp..user_fees uf
 inner join basicdata..[USER] u
  on uf.userid =u.userid 
 left join BasicData..user_class uc
  on u.userid = uc.userid
 left join basicdata..class c on c.cid=uc.cid
  where uf.kid=29048 
  order by cname,u.name
  
--查询重复缴费
  select userid,count(1) from payapp..sgs_pay_record
   where kid= 32833 and status=1 and crtdate>='2017-01-01'
   group by userid having count(1)>1
   
--支付绑定了用户的
select u.name 姓名,uf.crttime 缴费时间,u.cname 班级,uf.*
 from payapp..user_fees uf
 inner join basicdata..[USER_child] u
  on uf.userid =u.userid 
  where u.kid=29048 and crttime>='2016-3-1' and crttime<='2016-11-1'
  order by cname,u.name

--订单记录
select c.cname 班级,u.name 姓名,uf.crtdate 缴费时间,uf.*
 from payapp..sgs_pay_record uf
 inner join basicdata..[USER] u
  on uf.userid =u.userid 
 left join BasicData..user_class uc
  on u.userid = uc.userid
 left join basicdata..class c on c.cid=uc.cid
  where uf.kid=29312 
  order by cname,u.name
  
--微信支付没有绑定用户的
  select case when u.kid=0 then '离园' else '' end  状态 ,isnull(c.cname,uf.tel) 班级,isnull(u.name,uf.username) 姓名,uf.crtdate 缴费时间,uf.fee_name 套餐,uf.*
 from payapp..sgs_pay_record uf
 left join basicdata..[USER] u
  on uf.userid =u.userid 
 left join BasicData..user_class uc
  on u.userid = uc.userid
 left join basicdata..class c on c.cid=uc.cid
  where uf.kid=29312 and uf.crtdate>='2017-01-1'
   and uf.crtdate<='2018-01-1' and uf.status=1
  order by cname,u.name

----------------------------------------------------------------------
select u.cname 班级,u.name 姓名,r.actiondatetime 缴费时间,r.plus_amount 充值金额
 from payapp..order_record r
 inner join BasicData..[USER_child] u
  on r.userid = u.userid  
   where u.kid = 14979 and status=1 and r.[from] ='' and r.actiondatetime>='2015-06-01'
   order by cname,u.name

--[34148]广州市海珠区保利红棉幼儿园保利分园
--套餐2 OSS的数据和在线支付的数据不一致
select *  
from payapp..sgs_pay_record r
where kid=34147 and deletetag=1 and status=1
 and exists(select 1 from ossapp..addservice a
  where  a.uid=r.userid and a.deletetag=1 and a.describe='开通' and ltime>'2016-09-01' and a.a1=1202)
and exists (select 1 from BasicData..User_Child uc where uc.userid=r.userid)

select r.kid order_kid,u.kid,isnull(c.cname,'') cname,isnull(u.name,'') username,r.fee_money,r.PayType,r.crtdate,r.orderno,r.fee_name
--update r set kid=u.kid                   
 from PayApp..sgs_pay_record r    
 left join BasicData..[user] u on u.userid = r.userid     
 left join BasicData..[user_class] uc on uc.userid=u.userid   
 left join BasicData..[class] c on c.cid=uc.cid         
  where r.kid=34147 and r.crtdate>='2016-09-01' and r.crtdate<='2017-09-01' and r.status=1 and feetype in (3,4)
   and u.kid<>34147  --34147
   
select r.kid order_kid,u.kid,isnull(c.cname,r.cname) cname,isnull(u.name,r.username) username,
isnull(r.tel,'') tel,r.fee_money,r.PayType,r.crtdate,r.orderno,r.fee_name
--update r set kid=u.kid                   
 from PayApp..sgs_pay_record r    
 left join BasicData..[user] u on u.userid = r.userid     
 left join BasicData..[user_class] uc on uc.userid=u.userid   
 left join BasicData..[class] c on c.cid=uc.cid         
  where r.kid=31717 and r.status=1 --and r.crtdate>='2016-09-01' and r.crtdate<='2017-09-01'  --and feetype in (3,4)
   and u.kid<>31717  --34147
 

select a.kid,r.*  
from payapp..sgs_pay_record r
 inner join ossapp..addservice a
  on a.uid=r.userid and a.deletetag=1 and a.describe='开通' and ltime>'2016-09-01' and a.a1=1202
where r.kid=34148 and r.deletetag=1 and r.status=1
and exists (select 1 from BasicData..User_Child uc where uc.userid=r.userid)
order by a.kid,r.orderid


------------------------------------------------------------------------------------------
exec ossapp.[dbo].[addservice_vip_GetListTag] --1,1,7599,-1,'','','','-1','-1','','',''          
 @page =1          
,@size=1000       
,@kid=34148
,@txtcid=-1         
,@txtname=''          
,@txtaccount =''         
,@txttel =''         
,@txtispay ='-1'       
,@txtisopen ='1'
,@txtftime =''
,@txtltime =''
,@txtiskin ='1'
,@p1 =1202  --
-----------------------------------------------------------------------------
 
 
 --二维码支付  IEEP国际幼儿教育学习之旅IEEP报名费
http://payweixin.pc118.zgyey.com/sgspay/productPagev7.aspx?kid=1 --湖南分公司  --湖南郴州   bid=1
http://payweixin.pc118.zgyey.com/sgspay/productPagev7.aspx?kid=2 --海南分公司  --海南分公司 bid=47
http://payweixin.pc118.zgyey.com/sgspay/productPagev7.aspx?kid=3 --中幼                   bid=0
http://payweixin.pc118.zgyey.com/sgspay/productPagev7.aspx?kid=4 --山东分公司  --济南中幼 bid=5 
http://payweixin.pc118.zgyey.com/sgspay/productPagev7.aspx?kid=5 --汕头分公司  --潮汕代理 bid=40
山东一个汕头分公司


--expirestype  0按自然月，1：按具体时间， 2是无期限，一次性缴费
insert into payapp..fees([from],kid,fee_name,fee_des,expires,fee_money,deletetag,feetype,expirestype,expiresremark,expiresenddate,fee_kid,pay_bgndate,pay_enddate)
values('JSAPI',0,'IEEP国际幼儿教育学习之旅','',4,1980,1,4,0,'一学期','2017-09-01 23:59:59',5,'2017-01-01','2017-01-01')

select *
--update f set fee_name='IEEP国际幼儿教育学习之旅',fee_money=1
 from payapp..fees f where fee_kid=2 and [from]='JSAPI'
 
select *
--update f set bid=case when fee_kid=1 then 1 when fee_kid=2 then 47 when fee_kid=4 then 5 when fee_kid=5 then 40  else 0 end
--update f set bid_name=case when fee_kid=1 then '湖南分公司' when fee_kid=2 then '海南分公司' when fee_kid=3 then '中幼' when fee_kid=4 then '山东分公司' when fee_kid=5 then '汕头分公司' else '' end
 from payapp..fees f where fee_kid in(1,2,3,4,5) and [from]='JSAPI'
 
select * from ossapp..users where bid=1
select * from ossapp..agentbase where name like '%湖南郴州%' 
-------------------------------------------------------------------------------------

select * 
--update r set status=0
--update r set fee_money=1
--delete r
from sgs_pay_record r where crtdate>='2017-05-23' and [from]='JSAPI' and status=1 and orderid=10309

select * from ossapp..users where bid>0

-----------------------------------------------------------------------
时光树——我——健康服务包/成长档案(详见：《107、kmapp时光树权限控制.sql》)

---------------------------------------
select * from PayApp..sgs_pay_record where userid=2358989 and crtdate>='2017-09-01'

'13409750310'
payapp..sgs_GetUserFeeInfo 2358989

http://sgs.pay.zgyey.com/pay/index?kid=403&client=1&appver=4.1&uid=2358989&hxuid=2358989a0&role=2&feeid=213&key=34253ydfg675hr56
http://sgs.pay.zgyey.com/alipayto/CreateOrder?uid=2358989&feeid=213&from=SGS&timestamp=&key=34253ydfg675hr56

kid=403&client=1&appver=4.1&uid=2358989&hxuid=2358989a0&role=2&feeid=213&key=34253ydfg675hr56

select *from basicdata..[user] where account='txzx101'