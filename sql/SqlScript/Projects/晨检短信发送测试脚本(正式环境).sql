--套餐配置（包含晨检短信）
/*
update ossapp..addservice set a7=806,describe='开通',ltime='2016-09-01 00:00:00.000' where uid =487923
update ossapp..addservice set a7=0 where uid =487923
update mcapp..kindergarten set sendSet=null where kid=11061
update basicdata..[user] set mobile=null where userid=487923
update mcapp..kindergarten set sendSet=CommonFun.dbo.fn_RoleAdd(sendset,4) where kid=11061
update mcapp..kindergarten set sendSet=CommonFun.dbo.fn_RoleDel(sendset,4) where kid=11061
*/
--'1307009318','1303000754','1308009518'
456134	1307009318  806  李长虹  小小西瓜班
487923	1303000754  806  魏子沫  小小西瓜班
216044	1308009518  806    杨南     中一班

select *from mcapp..cardinfo where kid=11061 and usest<>1
update basicdata..[User] set mobile='13632432093' where userid in (487923,456134,216044)
select *from mcapp..cardinfo where card ='1307009318'
update mcapp..cardinfo set userid=456134,usest=1 where card='1307009318'
select * from basicdata..[User_Child]  where userid in (487923,456134,216044)
select * from basicdata..[leave_user_class] where userid=216044
select uc.userid,uc.kid,c.card,uc.name,uc.mobile from BasicData..User_Child uc
 left join mcapp..cardinfo c 
  on uc.userid=c.userid where uc.kid= 11061 and uc.userid in (487923,456134,216044)
select a7,* from ossapp..addservice where uid in (487923,456134,216044)
select CommonFun.dbo.fn_RoleGet(sendSet,1) 入园,CommonFun.dbo.fn_RoleGet(sendSet,2) 离园,
CommonFun.dbo.fn_RoleGet(sendSet,3) 正常短信,CommonFun.dbo.fn_RoleGet(sendSet,4) 时光树推送,CommonFun.dbo.fn_RoleGet(sendSet,5) 平台短信发送,*  
from  mcapp..kindergarten where kid=11061

select *from [CardApp].[dbo].[attendance_everymonth]   where userid in (487923) and year=2014 and month=9


456134	1307009318  806  李长虹  小小西瓜班
487923	1303000754  806  魏子沫  小小西瓜班
216044	1308009518  806    杨南     中一班

/*
李长虹tw:37.90,zz:2,8,11，需要体温偏高、家长带回确认；
魏子沫tw:36.90,zz:11，需要家长带回确认；
杨南tw:36.30,zz:11，晨检正常。
*/
insert into mcapp..stu_mc_day_raw (kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status)
 values(11061,487923,'1303000754','2016-06-13 8:00:00.000','37.90','2,8,11','2016-06-13 9:20:00.000','001106100','01',0 )
insert into mcapp..stu_mc_day_raw (kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status)
 values(11061,456134,'1307009318','2016-06-13 13:02:00.000','36.90','11','2016-06-13 13:25:00.000','001106100','01',0 )
insert into mcapp..stu_mc_day_raw (kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status)
 values(11061,216044,'1308009518','2016-06-13 8:04:00.000','36.30','11','2016-06-13 9:20:00.000','001106100','01',0)
 
/*
1)确认
李长虹tw:37.90,zz:2,8,11，确认为体温偏高，并且家长带回；
魏子沫tw:36.90,zz:11，确认家长带回；

2)
李长虹tw:37.90,zz:2,8,11，确认为体温偏高，未被家长带回；
魏子沫tw:36.90,zz:11，确认家长带回；

3)
李长虹tw:37.90,zz:2,8,11，确认为体温正常，家长带回；
魏子沫tw:36.90,zz:11，确认家长带回；

4)
李长虹tw:37.90,zz:2,8,11，确认为体温正常，未被家长带回；
魏子沫tw:36.90,zz:11，确认家长带回；
*/
--update mcapp..stu_mc_day set commit_zz='1,2,8,11',ftype=2 where Card='1303000754' and adate>='2016-06-13'
select * 
--Delete 
from sqlagentdb.dbo.mc_day_raw_message Where senddate = CONVERT(Varchar(10), GETDATE(), 120) and kid=11061   

select* from mcapp.dbo.stu_in_out_time Where userid=487923
select * 
--delete 
from  mcapp..stu_mc_day_raw where adate>='2016-06-13' and kid =11061 and card in('1307009318','1303000754','1308009518')
select * 
--delete  
from  mcapp..stu_mc_day where adate>='2016-06-13' and kid =11061 and card in('1307009318','1303000754','1308009518')
select * 
-- delete   stu_mc_day_highTw_GetModel
from mcapp..sms_mc_test 
where sendtime>='2016-06-13 15:00' and kid =11061
select * 
-- delete 
from mcapp..push_mc_test 
where writetime>='2016-06-13 15:00' and kid =11061   
select * 
-- delete 
from sms..sms_message 
where sendtime>='2016-06-13' and kid =11061
select * 
-- delete 
from mcapp..LogInfo_ex
where logtime>='2016-06-13 17:40' and kid =11061


症状编号	症状名称
1	体温偏高 
2	  咳嗽 
3	 喉咙发炎  
4	 流鼻涕   
5	皮疹   
6	腹泻 
7	红眼病 
8	 重点观察 
9	剪指甲 
10	服药提醒  
11	家长带回   