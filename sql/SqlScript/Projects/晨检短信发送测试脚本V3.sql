use mcapp
go
------------------个性化确认症状---------------------
--stu_mc_day_view
select * from sms_mc_test where writetime>=CONVERT(varchar(10),getdate(),120)
select * from push_mc_test where writetime>=CONVERT(varchar(10),getdate(),120)
select * from applogs..mc_log where crtdate>=CONVERT(varchar(10),getdate(),120) --where kid=12511 and crtdate>='2016-04-14 16:10'
select * from SendDoctorWeixinContentLog where crtdate>=CONVERT(varchar(10),getdate(),120)
select * from SendTeacherWeixinContentLog where crtdate>=CONVERT(varchar(10),getdate(),120)
select * from BasicData.dbo.weixin_message where crtdate>=CONVERT(varchar(10),getdate(),120)
select * from stu_mc_day where kid=11061 and adate>=CONVERT(varchar(10),getdate(),120)

select * from kmapp.dbo.user_sys_message where adddate>=CONVERT(varchar(10),getdate(),120)

/*
truncate table sms_mc_test
truncate table push_mc_test
truncate table applogs..mc_log
truncate table SendDoctorWeixinContentLog
truncate table SendTeacherWeixinContentLog
truncate table BasicData.dbo.weixin_message
delete from stu_mc_day 
*//*
李长虹tw:37.90,zz:2,8,11，需要体温偏高、家长带回确认；
魏子沫tw:36.90,zz:11，需要家长带回确认；
杨南tw:36.90,zz:11，晨检正常。
*/
insert into mcapp..stu_mc_day (checkdate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,sms_tw,sms_zz,commit_zz)
 values(CONVERT(varchar(10),getdate(),120),11061,456134,'1303000761',CONVERT(varchar(10),getdate(),120)+' 7:02:30.000','37.90','2,8,11',CONVERT(varchar(10),getdate(),120)+' 7:21:00.000','001106100','01',0,'37.90','2,8,11','' )
insert into mcapp..stu_mc_day (checkdate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,sms_tw,sms_zz,commit_zz)
 values(CONVERT(varchar(10),getdate(),120),11061,487923,'1303000754',CONVERT(varchar(10),getdate(),120)+' 7:03:11.000','36.90','11',CONVERT(varchar(10),getdate(),120)+' 7:21:00.000','001106100','01',0,'36.90','11','' )
insert into mcapp..stu_mc_day (checkdate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,sms_tw,sms_zz,commit_zz)
 values(CONVERT(varchar(10),getdate(),120),11061,216044,'1308009518',CONVERT(varchar(10),getdate(),120)+' 7:02:00.000','36.80','',CONVERT(varchar(10),getdate(),120)+' 7:21:00.000','001106100','01',0,'36.80','','' )

/*---------------校医确认---------------
--1)李长虹tw:37.90,zz:2,8,11，确认为体温偏高，并且家长带回；
  --魏子沫tw:36.90,zz:11，确认家长带回；
update mcapp..stu_mc_day set commit_zz='1,2,8,11',ftype=2 where Card='1303000761' and adate>=CONVERT(varchar(10),getdate(),120)
update mcapp..stu_mc_day set commit_zz='11',ftype=2 where Card='1303000754' and adate>=CONVERT(varchar(10),getdate(),120)
--2) 李长虹tw:37.90,zz:2,8,11，确认为体温偏高，未被家长带回；
   --魏子沫tw:36.90,zz:11，确认家长带回；
update mcapp..stu_mc_day set commit_zz='1,2,8',ftype=2 where Card='1303000761' and adate>=CONVERT(varchar(10),getdate(),120)
update mcapp..stu_mc_day set commit_zz='11',ftype=2 where Card='1303000754' and adate>=CONVERT(varchar(10),getdate(),120)
--3)李长虹tw:37.90,zz:2,8,11，确认为体温正常，家长带回；
  --魏子沫tw:36.90,zz:11，确认家长带回；
update mcapp..stu_mc_day set commit_zz='2,8,11',ftype=2 where Card='1303000761' and adate>=CONVERT(varchar(10),getdate(),120)
update mcapp..stu_mc_day set commit_zz='11',ftype=2 where Card='1303000754' and adate>=CONVERT(varchar(10),getdate(),120)
--4)李长虹tw:37.90,zz:2,8,11，确认为体温正常，未被家长带回；
  --魏子沫tw:36.90,zz:11，确认家长带回；
update mcapp..stu_mc_day set commit_zz='2,8',ftype=2 where Card='1303000761' and adate>=CONVERT(varchar(10),getdate(),120)
update mcapp..stu_mc_day set commit_zz='11',ftype=2 where Card='1303000754' and adate>=CONVERT(varchar(10),getdate(),120)
--------------------------*/

--需要一般异常；需要体温偏高确认；晨检正常。
insert into mcapp..stu_mc_day (checkdate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,sms_tw,sms_zz,commit_zz)
 values(CONVERT(varchar(10),getdate(),120),11061,456134,'1303000761',CONVERT(varchar(10),getdate(),120)+' 7:02:30.000','36.70','2',CONVERT(varchar(10),getdate(),120)+' 7:21:00.000','001106100','01',0,'36.70','2','' )
insert into mcapp..stu_mc_day (checkdate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,sms_tw,sms_zz,commit_zz)
 values(CONVERT(varchar(10),getdate(),120),11061,487923,'1303000754',CONVERT(varchar(10),getdate(),120)+' 7:03:11.000','37.90','',CONVERT(varchar(10),getdate(),120)+' 7:21:00.000','001106100','01',0,'37.90','','' )
insert into mcapp..stu_mc_day (checkdate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,sms_tw,sms_zz,commit_zz)
 values(CONVERT(varchar(10),getdate(),120),11061,216044,'1308009518',CONVERT(varchar(10),getdate(),120)+' 7:02:00.000','36.80','',CONVERT(varchar(10),getdate(),120)+' 7:21:00.000','001106100','01',0,'36.80','','' )

insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values(CONVERT(varchar(10),getdate(),120),11061,456134,'1303000761',CONVERT(varchar(10),getdate(),120)+' 7:10:00.000','36.90','8',CONVERT(varchar(10),getdate(),120)+' 7:20:00.000','001106100','01',0,0 )
insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values(CONVERT(varchar(10),getdate(),120),11061,487923,'1303000754',CONVERT(varchar(10),getdate(),120)+' 7:10:00.000','36.90','8,10',CONVERT(varchar(10),getdate(),120)+' 8:20:00.000','001106100','01',0,0 )
insert into mcapp..stu_mc_day (CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype)
values(CONVERT(varchar(10),getdate(),120),11061,216044,'1308009518',CONVERT(varchar(10),getdate(),120)+' 8:10:00.000','36.90','2',CONVERT(varchar(10),getdate(),120)+' 8:20:00.000','001106100','01',0,0 )

select *
--update d set ftype=1,commit_zz=''
--update d set commit_zz=''
from stu_mc_day d where kid=11061 and adate>=CONVERT(varchar(10),getdate(),120)


-------------基础资料------------
select * from cardinfo where card in('1303000761','1303000754','1308009518')
select * from basicdata..[User_Child] where userid in(456134,487923,216044)
select * 
--update a set describe='开通',ftime=getdate(),ltime=dateadd(mm,3,getdate())
from ossapp..addservice a where uid in(456134,487923,216044)
--update c set userid = 456134 from cardinfo c where card='1303000761'
--update c set userid = 487923 from cardinfo c where card='1303000754'
456134	1303000761  806  李长虹  68241 西瓜班
487923	1303000754  806  魏子沫  68241 西瓜班
216044	1308009518  806  杨南    38427 中一班

select uc.*,u.* 
--update u set mobile='13632432093'
from BasicData..[user] u inner join basicdata..user_class uc on u.userid=uc.userid
 where u.kid=11061 and u.usertype=1 and uc.cid in(38427,68241) and u.userid in(216369,1064557)
--insert into basicdata..user_class(cid,userid) values(38427,216369)

select * 
--update k set commit_zz ='1,7,8,10,11'
from mcapp..kindergarten k where kid=11061


------插入或者删除接受园长、校医、主班老师短信的名单---------------          
-- Paradef: @result int(0：电话号码不合格，1：设置成功，2：已存在3个，不能再设置,-1：保存失败)       
--@state 0:删除、1：园长短信、2：校医短信、3：老师短信、4：幼儿离园、5：老师考勤、6：老师管理时光树幼儿资料、7：管理员、园长、老师管理时光树老师资料    
               
EXEC mc_sms_man_setting @kid=11061,@cid=38427,@userid=216369,@state=3,@oldstate=0,@douserid=134
EXEC mc_sms_man_setting @kid=11061,@cid=68241,@userid=216369,@state=3,@oldstate=0,@douserid=134  
EXEC mc_sms_man_setting @kid=11061,@cid=68241,@userid=1064557,@state=3,@oldstate=0,@douserid=134 

--Commit tran      


;with data as(
select ID,CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype,sms_tw,sms_zz,commit_zz           
  from stu_mc_day d     
  where d.kid = 11061                
   and d.CheckDate>= CONVERT(varchar(10),getdate(),120)         
   and d.CheckDate<= CONVERT(varchar(10),dateadd(dd,1,getdate()),120)           
   and ftype>0 
),data2 as( 
select * 
from data d 
 cross apply(select * from CommonFun.dbo.f_split(d.sms_zz,','))z
),permission as(
 select * from kindergarten k cross apply(select * from CommonFun.dbo.f_split(k.commit_zz,','))z
   where kid=11061
)
select distinct ID,CheckDate,kid,stuid,card,cdate,tw,zz,adate,devid,gunid,Status,ftype,sms_tw,sms_zz,commit_zz
 from data2 d where exists(select * from permission p where p.col=d.col) 


select * from mcapp..zz_dict