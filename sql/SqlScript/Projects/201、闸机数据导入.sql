use mcapp
go



--还有一些卡没有绑定gate_card
select * from mcapp..cardinfo where kid= 31996 and usest>=0  order by gate_card
select * from mcapp..cardinfo c
 inner join BasicData..[USER_child] u 
  on c.userid= u.userid
   where c.kid= 31996 and c.gate_card is null  order by gate_card

--查询用户，权限
select * from mcapp..gate_command_data where crtdate>='2016-05-25'

--初始化数据。
init_ZKAccess @kid=33301,@sn='3013161600080',@priority=1,@deletedOldData=1

mcapp..[init_gate_pin] @kid=33681
select * from basicdata..[user] where kid=12511 and name='夏晴'   userid=295725


select * from mcapp..gate_device where kid=33301
select *
-- update c set status=0
 from mcapp..gate_command c where kid=33301 and crtdate>='2016-8-05' and status<2


--批量导入
insert into mcapp..cardinfo(kid,card,udate,usest,CardType,userid,memo,DoUserid,DoWhere,gate_card,gate_pin)
select 34185,cardno,GETDATE(),0 usest,1 CardType,0 userid,'' memo,134 DoUserid,0 DoWhere,gata_card,0 gate_pin
 from gbapp..user_Card_temp t
 where gata_card<>'' and cardno<>'' and not exists(
select 1 from mcapp..cardinfo c where c.kid=34185 and c.card=t.cardno --and CardType=0 
)


--单条导入
insert into mcapp..cardinfo(kid,card,udate,usest,CardType,userid,memo,DoUserid,DoWhere,gate_card,gate_pin)
select 20938,'3775056720',GETDATE(),0 usest,1 CardType,0 userid,'' memo,134 DoUserid,0 DoWhere,'3775056720',0 gate_pin

select * 
--update c set gate_card=card
from mcapp..cardinfo c
where kid in( 29139,33296) and 
udate>='2016-08-31' and usest=0 and gate_card is null

delete from gbapp..user_Card_temp

--检查数据重复
select cardno,COUNT(cardno) from gbapp..user_temp where id>2061 group by cardno having COUNT(cardno)>1
select * from gbapp..user_temp where cardno ='3781369556'


select *
--update c set gate_card='3255166949',kid=34257,usest=0,userid=0,opencarddate=null
from mcapp..cardinfo c where card='1307009021'

select *
--update c set gate_card='95422810'
from cardinfo c where card='1607900005'

select * from cardinfo where card in('1607900052','1607900098','1607900005')
-------------------------------------------------------------
--找出oss后台没有资料的学生
select *
 from gbapp..user_temp t
  where id>2061 and t.cname <>'教师临时用卡' and not exists
  ( select 1 from BasicData..[User_Child] uc
   where uc.kid=20938 and t.cname=uc.cname and uc.name=t.uname)

--批量学生开卡
select uc.cname,uc.name,c.userid,c.usest,c.udate,c.openCardDate,c.card,c.gate_card,c.gate_pin,uc.userid
--update c set gate_card=c.card,userid=uc.userid,usest=1,opencarddate=getdate()
 from mcapp..cardinfo c
  inner join gbapp..user_temp t on t.id>2061 and c.card=t.cardno and c.kid=20938
  inner join BasicData..[User_Child] uc
   on uc.kid=20938 and t.cname=uc.cname and uc.name=t.uname and t.cname <>'教师临时用卡' and c.gate_card is null

mcapp..[init_gate_pin] 33681  33301
----------------------------------------------------------

select * from BasicData..[User_Teacher] uc where kid=20938 and updatetime>='2016-07-12 17:00:33.930'
--批量老师开卡
select c.userid,c.usest,c.udate,c.openCardDate,c.card,c.gate_card,c.gate_pin,uc.userid
--update c set gate_card=c.card,userid=uc.userid,usest=1,opencarddate=getdate()
 from mcapp..cardinfo c
  inner join gbapp..user_temp t on c.card=t.cardno and c.kid=20938
  inner join BasicData..[User_Teacher] uc 
   on uc.kid=20938 and updatetime>='2016-07-12' and uc.userid=t.userid and c.gate_card is null


select uc.name,t.uname,*
--update uc set name=t.uname
 from BasicData..[User] uc 
  inner join gbapp..user_temp t 
   on uc.usertype=1 and uc.kid=20938 and updatetime>='2016-07-12 17:00:33.930' and uc.userid=t.userid --and c.gate_card is null
   
   
select * from BasicData..[User_Teacher] uc where kid=20938 and updatetime>='2016-07-12 17:00:33.930'

select * from gbapp..user_temp t where t.cname ='教师临时用卡' order by uname

alter table user_temp add crtdate datetime default(getdate())

-----------------单个修改------------------------------------
select * from mcapp..cardinfo where card ='3780773716'
select * from BasicData..User_Child where userid=2116927




1507016807 对应物理卡号 3119036281
1507079028 对应物理卡号 1725995682

select *
--update c set gate_card='1725995682',kid=33681,usest=0,opencarddate=null,userid=0
--update c set gate_card='3119036281',card='1507016807',userid=2116927,usest=1,opencarddate=getdate()
 from mcapp..cardinfo c
 where card='1507016807'  3781369556
 
 select * from mcapp..cardinfo c where kid = 20938 and CardType=0


select distinct cname from gbapp..user_temp t order by cname
select distinct cname from BasicData..User_Child t where kid = 20938 order by cname
select MAX(id) from gbapp..user_temp t

--maxid= 1862

select * 
-- update t set cname='当当班'
from gbapp..user_temp t where cname='精托班'

select * from mcapp..cardinfo c
 where kid=20938 and exists(select 1 from gbapp..user_temp t where t.cardno=c.card)
 
 


32507广州市萝岗区小太阳幼儿园总园/32524广州市萝岗区小太阳幼儿园分园，帮忙配置下微信支付二维码


 180 元/人/学期。3.缴费期限：  2016年9月6日-  2016年9月14日。以后每学期借阅证办理时间：
 为开学的第一个月内，错过办理时间的请在下一个办理时间内办理。

declare @fee_kid int=32524,@pay_bgndate datetime='2016-09-06',@pay_enddate datetime='2016-09-14'
insert into payapp..fees([from],kid,fee_name,fee_des,expires,fee_money,
deletetag,feetype,expiresType,expiresRemark,expiresenddate,fee_kid,pay_bgndate,pay_enddate)
--declare @fee_kid int=32507,@pay_bgndate datetime='2016-09-06',@pay_enddate datetime='2016-09-14'
select 'WX_JSAPI',0,fee_name,'' fee_des,expires,180 fee_money,
deletetag,feetype,expiresType,expiresRemark,expiresenddate,@fee_kid fee_kid,@pay_bgndate pay_bgndate,@pay_enddate pay_enddate
 from payapp..fees where fee_id=170
 
select *
--update f set pay_bgndate='2016-09-02'
  from payapp..fees f where fee_kid=6318
  
  
select *
-- update c
--delete c
 from mcapp..cardinfo c
inner join user_Card_temp t on c.card=t.cardno
 and c.kid=26490 and c.gate_card is null

  