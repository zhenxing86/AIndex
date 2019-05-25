use PayApp
go

select * from payapp..sgs_pay_record where kid=20581 and status=1 and crtdate>='2018-07-01'
--1) 订单
select * from payapp..sgs_pay_record where userid =1998451
select * from payapp..sgs_pay_record where kid=29312 and crtdate>='2018-04-01' and crtdate<'2018-08-01'
--2) 触发器
payapp..trg_sgs_pay_record
--3) 开通阅读
--EXEC ossapp..[addservice_vip_Add_ReadAuto_test]                    
--@cuid ='1998451'--要开的人的userid                           
--,@isproxy =3--2老师帮开，3学生自己开                    
--,@uid =1998451--操作人userid--学生的话就是自己       
--,@orderid  = 17269

select * from payapp..user_fees where userid=1998451 
select * from payapp..user_fees_log where userid=1998451 
select *from logdata..ossapp_keylog where uid=1998451


--exec addservice_status_Add @typename,@kid,@cid,@cuid,@p1,@ftime,@ltime,@isopen,@uid  --记录开通 
select * from ossapp..addservice_status_log where userid=1998451 
--4）
declare @kid int=20581,@cid int,@p1 int,@cuid int=1998451                                                     
declare @term int =1,@termstr varchar(100),@expiresType int,@expiresEnddate datetime                                       
select @kid=kid,@cid=cid from basicdata..User_Child where userid=@cuid                        
select @p1=f.ID,@term=s.expires,@expiresType=isnull(expiresType,0),@expiresEnddate=isnull(expiresEnddate,'2010-01-01')              
 from ossapp.dbo.feestandard f                         
inner join [PayApp].[dbo].[fees] s on s.fee_id=f.sgsfeeid and s.deletetag=1 and s.kid=f.kid and s.[from]='ATS' and feetype=3                       
where f.kid=@kid and f.deletetag=1    
select @p1,@term,@expiresType,@expiresEnddate
select * from ossapp..feestandard f
 inner join ossapp..dict d on f.a1=d.ID and d.name='套餐名称' where f.id=@p1
 
--5) exec ossapp..[addservice_vip_Add_child_test] @typename,@kid,@cid,@cuid,@p1,@ftime,@ltime,@ispay,@isopen,@paytime,@isproxy,@uid,0,1,@orderid
select * from LogData..ossapp_addservice_log where uid=1998451 order by id  
select * from ossapp..[addservice] where uid=1998451
 


select * from ossapp..payapp_userstate where userid=1998451

--Select * From blogapp..permissionsetting Where kid = 20581 and ptype = 105

---------------------------------没有缴费，但是开通了vip的用户2018-07-01-----------------------------------------
select uc.cname,uc.account,uc.userid,uc.name,case when PayType=1 then '支付宝' else '微信' end PayType,crtdate,* 
from payapp..sgs_pay_record s 
 inner join BasicData..user_child uc on s.userid=uc.userid
where s.kid=34819 and crtdate>='2018-07-01' and s.status=1

select * from ossapp..addservice a where kid=29312 and describe='开通' and ltime>='2018-12-01' and a10>0 and a1<>2000

select uc.cname,uc.account,uc.userid,uc.name from ossapp..addservice a inner join BasicData..user_child uc on a.uid=uc.userid
where a.kid=34819 and describe='开通' and ltime>='2018-12-01' and a10>0 and a1<>2000 and uc.grade<>38
and not exists(select 1 from payapp..sgs_pay_record s where s.userid=a.uid and s.crtdate>='2018-07-01' and s.status=1)


select * from ossapp..addservice a where uid=2134756
select * from basicdata..User_Child where kid=3638 and name= '鲍田田'


--select * from ossapp..dict where name like '%套餐%'

--[34819]佛山顺德区勒流中心幼儿园，麻烦关闭掉没有缴费但是开通借阅的小朋友。实际缴费只有2人石栩萱；张雪@谢振兴 谢谢啦


update addservice set a10=0 where describe='开通' and ltime>='2018-12-01' and a10>0 and a1<>2000 and uid=