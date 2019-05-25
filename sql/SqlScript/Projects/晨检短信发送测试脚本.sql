晨检短信发送测试脚本

---------------晨检异常短信发送  发送异常短信-----------------
--开通套餐（包含晨检短信）
update ossapp..addservice set a7=806,describe='开通',pname='套餐',vippaystate=1 where uid =653612
--设置主班老师
if not exists( select 1 from mcapp..sms_man_kid 
 where userid = 653605 and cid=55906 and kid=12511 and roletype=3
)
insert into mcapp..sms_man_kid(userid,kid,cid,roletype)
select 653605,12511,55906,3

--插入晨检数据
insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values('2014-05-12',12511,653612,'1303001701','2014-05-12 08:10:00.000','36.90','2,8,9','2014-05-12 10:00:00.000','001251100','03',0,0 )
--查询晨检短信
select * from mcapp..sms_mc 
where sendtime>='2014-05-12' and
kid = 12511 
order by sendtime desc

--删除测试数据
delete from mcapp..stu_mc_day where kid = 12511 and adate>='2014-05-12'
delete from mcapp..sms_mc where  sendtime>='2014-05-12'  and kid = 12511

---------------晨检异常短信发送(刷卡时间与上传时间的间隔相差大于180分钟) 不发送短信-----------------
--插入晨检数据
insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values('2014-05-12',12511,653612,'1303001701','2014-05-12 7:10:00.000','36.90','2,8,9','2014-05-12 15:20:00.000','001251100','03',0,0 )
--查询晨检短信
select * from mcapp..sms_mc 
where sendtime>='2014-05-12' and
kid = 12511 
order by sendtime desc

--删除测试数据
delete from mcapp..stu_mc_day where kid = 12511 and adate>='2014-05-12'
delete from mcapp..sms_mc where  sendtime>='2014-05-12'  and kid = 12511

---------------晨检异常短信发送(当前时间不在发送家长短信时间段内) 不发送短信-----------------
--插入晨检数据
insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values('2014-05-12',12511,653612,'1303001701','2014-05-12 19:10:00.000','36.90','','2014-05-12 19:20:00.000','001251100','03',0,0 )
--查询晨检短信
select * from mcapp..sms_mc 
where sendtime>='2014-05-12' and
kid = 12511 
order by sendtime desc

--删除测试数据
delete from mcapp..stu_mc_day where kid = 12511 and adate>='2014-05-12'
delete from mcapp..sms_mc where  sendtime>='2014-05-12'  and kid = 12511

-----------------晨检正常短信发送 发送正常短信--------------------------


--设置需要发送晨检正常短信的幼儿园
update mcapp..kindergarten set sendSet=CommonFun.dbo.fn_RoleAdd(sendset,3)
 where kid = 12511
if @@ROWCOUNT<=0
insert into mcapp..kindergarten (kid,kname,sendSet)
select 12511,'晶晶大拇指幼儿园',3

--插入晨检数据
insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values('2014-05-12',12511,653612,'1303001701','2014-05-12 08:10:00.000','36.90','','2014-05-12 11:00:00.000','001251100','03',0,0 )
--查询晨检短信
select * from mcapp..sms_mc 
where sendtime>='2014-05-12' and
kid = 12511 
order by sendtime desc

--删除测试数据
delete from mcapp..stu_mc_day where kid = 12511 and adate>='2014-05-12'
delete from mcapp..sms_mc where  sendtime>='2014-05-12'  and kid = 12511


-----------------晨检正常短信发送 不发送正常短信--------------------------
--取消设置需要发送晨检正常短信的幼儿园
update mcapp..kindergarten set sendSet=CommonFun.dbo.fn_RoleDel(sendset,3)
 where kid = 12511
 
 --插入晨检数据
insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values('2014-05-12',12511,653612,'1303001701','2014-05-12 08:10:00.000','36.90','','2014-05-12 11:00:00.000','001251100','03',0,0 )
--查询晨检短信
select * from mcapp..sms_mc 
where sendtime>='2014-05-12' and
kid = 12511 
order by sendtime desc

--删除测试数据
delete from mcapp..stu_mc_day where kid = 12511 and adate>='2014-05-12'
delete from mcapp..sms_mc where  sendtime>='2014-05-12'  and kid = 12511