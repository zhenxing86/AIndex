select kid,cardno,crtdate from mcapp..cardinfo where kid in(
14702,14933,14934,
14935,14979,15028,15864,
19290,22638,24878,25294,
29542,29543,29544,29545,
32155,34134,34141,34274,
35099,35483,36420,36699,
37046,37228,25119
) and crtdate>='2019-02-24' and crtdate<='2019-04-15'
order by kid,crtdate



--小谢。403麻城市幼儿园的麻烦帮我查一下他们家长购卡的总数和把1月6日到今天的导出来给我一下。谢谢！
--购买晨检卡的名单

select * from PayApp..fee_buytime_Order  where kid=403
select * from PayApp..userfee_buytime where kid=403
select * from PayApp..fees_buytime
select * from PayApp..subfees_buytime  where kid=403
select * from PayApp..fees where kid=403
select * from PayApp..fees where fee_kid=20581

--顺便导下  5-5到5-9号的 家长买卡的记录
select r.fee_name,uc.cname,uc.name,crtdate,* from PayApp..sgs_pay_record r 
 left join BasicData..User_Child uc on r.userid=uc.userid
 where r.kid=403 and r.status=1 and r.fee_id=209
 and r.crtdate>='2017-6-5' and r.crtdate<='2017-6-9'
 --and uc.name is null
 and r.userid in( 2186010)
 
select r.fee_name,uc.cname,uc.name,crtdate,* from PayApp..sgs_pay_record r 
 left join BasicData..User_Child uc on r.userid=uc.userid
 where r.kid=20581 and r.status=0 and r.fee_id=496
 and r.crtdate>='2018-12-11' and r.crtdate<='2019-6-9'
 --and uc.name is null

select * 
--update r set status=1
--delete r
from PayApp..sgs_pay_record r  where orderid=19882

select * 
--delete r
from PayApp..user_fees r  where userid=2533920

 --这学期分配卡情况  kid,卡数量，大卡数量，小卡数量
 
select kid,COUNT(1) 卡数量,SUM(case when cardtype=0 then 1 else 0 end) 大卡数量,SUM(case when cardtype=1 then 1 else 0 end) 小卡数量
from mcapp..cardinfo 
where kid in(27485,27486,29279,29503,29916,29951,29976,31755,31788,31790,32739,32740,32741,32936,33078,33079,33102,33115,33293,33508,33839,33882,33883,34091,34096,34213,34230,34957,35001,35196,35218,35223,35547,35564,35834) 
and crtdate>='2017-01-01'
group by kid

-------------------------------------------




-------------------------------------------购买晨检卡配置----------------------------------------------------------------------
use payapp
go

--[15028]济南市市中区舜南幼儿园幼儿园__实行家长自行在时光树上购卡30元/张

--手机客户端支付。（在WEB端打开）
http://sgs.pay.zgyey.com/cardpay/index?kid=23967&client=1&appver=1.085&uid=862914&role=2&feetype=5
http://sgs.pay.zgyey.com/cardpay/index?kid=20675&client=1&appver=1.085&uid=1536233&role=2&feetype=5

--expirestype  0按自然月，1：按具体时间， 2是无期限，一次性缴费
insert into fees([from],kid,fee_name,fee_des,expires,fee_money,deletetag,feetype,expirestype,expiresremark,expiresenddate,fee_kid,pay_bgndate,pay_enddate)
values('cardpay',0,'购买晨检卡','晨检卡35元一张',0,35,1,5,2,'','2016-09-30',20581,'2016-09-30','2016-09-30')

select * 
--update f set deletetag=1
--update f set fee_money=35
--update f set expirestype=2,fee_name='购买晨检卡',fee_des='幼儿园晨检接送卡工本费用15元/张。购买成功后，到幼儿园领取晨检卡',expiresremark='晨检卡15元一张',fee_money=15
from payapp..fees f where fee_kid=20581 and feetype=5

--开放缴费入口权限，ptype=901，在时光树——健康中心——购买晨检卡
insert into blogapp..permissionsetting(ptype,kid,group_no) values(901,20581,0)

select * 
--delete 
from blogapp..permissionsetting where ptype=901  and kid=20581

select * from payapp..fees f where [from]='cardpay'
select * from BasicData..[User] where kid=15028 and usertype=0 and deletetag=1
select * from BasicData..[User] where kid=36420 and usertype=0 and deletetag=1

--http://tm.sgspay.zgyey.com/H5Pay/Index?kid=12511 (无效)
 
 
 ------------------------------------------
 use mcapp
 go
 --[34548]昆明学院附属经开幼儿园 --小董跟进的园  select * from ossapp..users where bid=0 and name like '%董%'
 
declare @kid int=34548,@DoReason nvarchar(200)='欠费,小董要求挂失',@douserid int=57

UPDATE c SET usest = -1,memo=@DoReason,userid = null,old_userid=c.userid,old_usertype=case when u.usertype=0 then 0 else 1 end,loss_time=GETDATE()    
 output deleted.kid,deleted.card,GETDATE(),inserted.usest,deleted.CardType,inserted.userid,deleted.EnrolNum,@douserid,2,deleted.openCardDate,inserted.memo,'127.0.0.1'
   into cardinfo_log(kid,card ,udate ,usest ,CardType ,userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,ipaddr)           
--select c.kid,card ,udate ,usest ,CardType ,c.userid ,EnrolNum ,DoUserid ,DoWhere ,openCardDate,memo,'127.0.0.1'                 
FROM cardinfo c  
inner join BasicData..[user] u on c.userid=u.userid              
and c.kid = @kid and u.deletetag=1
and c.usest = 1

select * from mcapp..cardinfo_log where kid=34548 and udate>='2018-06-25' order by id desc