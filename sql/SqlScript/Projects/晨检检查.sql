--1体温偏高 2咳嗽 3喉咙发炎 4流鼻涕 5皮疹 6腹泻 7红眼病 8重点观察 9剪指甲 10服药提醒 11家长带回 


select k.kid,ISNULL(k.kname,ok.kname) '幼儿园名称',CommonFun.dbo.fn_RoleGet(sendset,6) '入园APP',CommonFun.dbo.fn_RoleGet(sendset,1) '入园SMS', CommonFun.dbo.fn_RoleGet(sendset,7) '离园APP'
,CommonFun.dbo.fn_RoleGet(sendset,2) '离园SMS',CommonFun.dbo.fn_RoleGet(sendset,4) '晨检正常APP', CommonFun.dbo.fn_RoleGet(sendset,5) '晨检正常SMS'
,CommonFun.dbo.fn_RoleGet(sendset,3) '晨检正常(已废弃)',CommonFun.dbo.fn_RoleGet(sendset,8) '晨检异常APP', CommonFun.dbo.fn_RoleGet(sendset,9) '晨检异常SMS'
 from mcapp..kindergarten k
 left join ossapp..kinbaseinfo ok
  on k.kid = ok.kid 
 inner join BlogApp..permissionsetting p
  on k.kid = p.kid and ptype=90
  where k.kid = 12511
  order by k.kid
 
update mcapp..kindergarten set sendSet=480  where kid=24082

select * from  AppLogs.dbo.EditLog where DbName = 'mcapp' and tbname='kindergarten' and KeyCol=18208 order by crtdate
select * from LogData..site_log where describe like 'ID为29525的幼儿园%'
select * from applogs..permissionsetting_log where kid =29525
select * from applogs..permissionsetting_log where kid =18208
select * from BlogApp..permissionsetting where kid=18208

--没有配置晨检正常短信发送，但是发了正常短信的
select  * from mcapp..sms_mc d
 left join mcapp..kindergarten k on d.kid= k.kid and commonfun.dbo.fn_RoleGet( k.sendSet,5) >0 
 where d.writetime>='2015-09-22' and d.smstype=12 and k.kid is null
 
--没有配置晨检正常时光树发送，但是发了正常短信的
select  * from mcapp..push_mc d
 left join mcapp..kindergarten k 
  on d.kid= k.kid and commonfun.dbo.fn_RoleGet( k.sendSet,4) >0
 where d.writetime>='2015-09-22'  and d.type='晨检正常短信' and k.kid is null
 
 applogs.dbo.mc_log
--test 到正式
select  * from mcapp..stu_mc_day where adate>='2015-09-21 11:30' and ftype=1
select * from mcapp..sms_mc_test
select * from mcapp..push_mc_test

select * from mcapp..sms_mc where writetime>='2015-09-21 11:30' and smstype=12
select * from mcapp..push_mc where writetime>='2015-09-21 11:30' and smstype=12

select  * from mcapp..sms_mc_test d
 inner join mcapp..kindergarten k on d.kid= k.kid and commonfun.dbo.fn_RoleGet( k.sendSet,9) >0
 
select  * from mcapp..push_mc_test d
 inner join mcapp..kindergarten k on d.kid= k.kid and commonfun.dbo.fn_RoleGet( k.sendSet,8) >0

sqlagentdb..[Move_mc_sms_from_test]

  
SELECT * from mcapp..stu_mc_day d
 inner join BasicData..User_Child uc
  on d.stuid=uc.userid
   where d.kid =28240 and cdate>='2015-09-11'
SELECT * from mcapp..stu_mc_day where kid =28240 and cdate>='2015-09-11'

declare @id int 
select  @id=MAX(id)+1 from MCAPP..stu_mc_day_raw
insert into MCAPP..stu_mc_day_raw(id,stuid,card,cdate,tw,zz,ta,toe,devid,gunid,kid,Status,adate)
select @id,0,'1303001642',getdate(),tw,zz,ta,toe,'001251100',gunid,kid,0,getdate() from MCAPP..stu_mc_day_raw where 
ID = 1858711

select *from applogs..EditLog where DbName='mcapp' and TbName='kindergarten' and KeyCol=23731
select *from applogs..EditLog where DbName='mcapp' and TbName='kindergarten' and KeyCol=28240

select CommonFun.dbo.fn_RoleGet(22,2)


select DATEDIFF(ss,crtdate,enddate),DATEDIFF(ss,startdate,enddate),* from mcapp..mc_file_record where crtdate>='2015-01-22' and totalCnt>0 
order by DATEDIFF(ss,crtdate,enddate) desc

select DATEDIFF(ss,crtdate,enddate)/60.0,* from mcapp..mc_file_record order by DATEDIFF(ss,crtdate,enddate) desc

 select * From mcapp..stu_mc_day_raw where kid=27236 and cdate>='2015-09-14' and card in(
  select card from mcapp..cardinfo c
   inner join basicdata..[user] u 
    on c.userid=u.userid and u.usertype=0
   inner join BasicData..user_class uc
    on u.userid = uc.userid --and uc.cid =97476 
   where u.kid=27236 -- and u.name in ('刘劭洋')
 )
 

 
 --22256有个小朋友账号是13577327897，9.23晨检时是有刷卡的，但健康中心那里没有入园的时间记录，只有离园记录
原因：也就是15081112 这支枪 这两天上传的数据都有问题。
select * from mcapp..stu_mc_day_raw r
inner join mcapp..cardinfo ci on r.card =ci.cardno
inner join BasicData..User_Child uc on ci.userid = uc.userid
where --r.kid =14496 and 
r.cdate>='2015-09-23'
--and uc.userid = 1576095 
and uc.account='13577327897'

select * from BasicData..[User_Child] where kid = 29401 and name ='唐米涵'
select * from mcapp..stu_mc_day d
 inner join mcapp..cardinfo c on d.card=c.card
  where d.kid = 29401 and c.userid = 1531207 and CheckDate ='2015-10-09'
select * from mcapp..stu_mc_day_raw d inner join mcapp..cardinfo c on d.card=c.card
  where d.kid = 29401 and c.userid = 1531207 and CONVERT(varchar(10), cDate,120)='2015-10-09'

select smd.* from BasicData..User_Child uc
left join mcapp..stu_mc_day_raw smd on uc.userid=smd.stuid
where --uc.kid =14496 and uc.cid=79184 and
 smd.cdate>='2015-09-23'
and uc.account='13577327897'




 select * From mcapp..mc_file_record where kid=29525 and crtdate>='2015-09-09'
 select * From mcapp..stu_mc_day_raw  where kid=29525 and adate>='2015-09-09'
 
 --{"toe":"33.1","gunid":"15081112","stuid":0,"tw":"36.4","ta":"26.0","card":"1506038929","zz":"","cdate":"2013-01-10 09:19:37"}
select * from mcapp..stu_mc_day_raw_error 
where card='1506038929' and adate>='2015-09-23'

select * from mcapp..stu_mc_day_raw_error 
where kid= 29501 and adate>='2015-12-23' and adate<'2015-12-24'  order by cdate 

select * from mcapp..stu_mc_day_raw_error 
where kid= 26490 and adate>='2015-12-28' order by cdate 

 
select * from mcapp..stu_mc_day_raw
where kid= 26490 and Convert(varchar(10),adate,120)='2015-12-22' and gunid<>'15082243' order by cdate 

[26490]德阳外国语幼儿园@谢振兴，这家园有一支枪时间不对，麻烦处理一下数据哦，刷卡时间在8:30分左右，谢谢啦

 --error表到 raw表（补救）
select datediff(SECOND,'2013-01-13 00:58:07','2015-12-28 08:31:33')
insert into mcapp..stu_mc_day_raw_temp(stuid,card,cdate,tw,zz,ta,toe,devid,gunid,kid,Status,adate)
select stuid,card,dateadd(second,93252806,cdate),tw,zz,ta,toe,devid,gunid,kid,Status,adate
 from mcapp..stu_mc_day_raw_error  where kid =26490 and  adate>='2015-12-28'
 order by cdate 
 

insert into mcapp..stu_mc_day_raw_temp(stuid,card,cdate,tw,zz,ta,toe,devid,gunid,kid,Status,adate)
select stuid,card,dateadd(yy,4,cdate),tw,zz,ta,toe,devid,gunid,kid,Status,adate
 from mcapp..stu_mc_day_raw_error  where kid =26490 and adate>='2015-12-16' --and adate<'2015-09-25' 
 order by cdate 
 
 
select gunid from mcapp..stu_mc_day_raw
where kid= 26490 and Convert(varchar(10),adate,120)='2015-11-04' 
group by gunid
 
select * from mcapp..stu_mc_day where card ='1401004182'  and adate>='2015-09-01'
select * from BasicData..[user] where userid =295765
select * from BasicData..[user_child] where userid =295765
select * from BasicData..[user_teacher] where userid =295765

select * from mcapp..cardinfo where userid =295765

2016-3-1

--测试晨检SMS服务。

select  *from mcapp..stu_mc_day where card ='1401004182' and  ID= 2828439
select  *from mcapp..stu_mc_day where card ='1401004182' and CheckDate='2015-12-19' and  ID =9942536

update mcapp..stu_mc_day set CheckDate='2015-12-19', cdate='2015-12-19 09:10:03.870',adate='2015-12-19 09:10:14.870',ftype=0,Status=0,sms_zz='8,10',zz='8,10'
where card ='1401004182'  and ID=9942536 2828439  

mc_monitor_Add

select * delete from mcapp..mc_monitor_add_exec
select  * from mcapp..stu_mc_day where adate>='2015-09-21 11:30' and ftype=1
select  count(1) from mcapp..stu_mc_day where adate>='2015-09-21 11:30' and ftype=1
select  *from mcapp..sms_mc where  writetime>='2015-12-19 18:00' and kid=12511
select  *from mcapp..push_mc where  writetime>='2015-12-19' and kid=12511

select  *from mcapp..sms_mc where writetime>='2015-10-12' recuserid = 295765 and 
select  *from BigLog..LogInfo_ex where  logtime>='2015-12-19'

select * from mcapp..sms_mc_test --where recuserid=295765 and sendtime>='2015-12-19'
select * from mcapp..push_mc_test --where userid=295765 and writetime>='2015-09-15'
select * from applogs..[mc_log] where crtdate>='2015-12-19 18:00' and  userid=295765 and

delete mcapp..sms_mc_test
delete mcapp..push_mc_test



--ROW_NUMBER() over(partition by u.userid order by u.userid) rowid

;with cet as(
select u.userid
 From mcapp..stu_mc_day_raw r --where kid=27236 and cdate>='2015-09-14' and card in(
  inner join mcapp..cardinfo c
   on c.card = r.card
   inner join basicdata..[user] u 
    on c.userid=u.userid and u.usertype=0
   --inner join BasicData..user_class uc
   -- on u.userid = uc.userid --and uc.cid =97476 
   where u.kid=27236  and cdate>='2015-09-14' -- and u.name in ('刘劭洋')
 group by u.userid,u.name
 having COUNT(1)>1
)
 select * from mcapp..stu_mc_day_raw r where r.kid=16208  and cdate>='2015-09-14'
 and exists(select 1 from mcapp..cardinfo c
  inner join cet cc
   on c.userid = cc.userid and c.kid=16208
   where r.card = c.card
   )
   

 select* from mcapp..mc_file_record where kid=16208 and  crtdate>='2015-09-20'
 
 select * from BasicData..User_Child uc
  left join mcapp..Mc_Photo mc
   on mc.userid=uc.userid where kid =29317 and uc.userid in (1567342,1567412,
1567422,
1568703)


   exec ossapp..basicdata_user_Update_Mc_PhotoDate  1567412, '/photodown/29317/1567422/','stu.jpg'  
   exec ossapp..basicdata_user_Update_Mc_PhotoDate  1567412, '/photodown/29317/1567422/','p1.jpg'  
   exec ossapp..basicdata_user_Update_Mc_PhotoDate  1567422, '/photodown/29317/1567422/','p2.jpg'  

select * from basicdata..User_Child where kid = 29317 and name in(
'孙嘉琪',
'黎湘莹',
'黎湘颖')

http://m.class.zgyey.com/122011/videoshow_v115690.html

即videoview改成videoshow
幼儿园管理员发了班级视频

select imgs= replace(imgs,'videoview','videoshow'), * 
-- update t set imgs= replace(imgs,'videoview','videoshow')
from kmapp..twitter t 
where ftype =2 and albumid=-1 and adddate>='2015-09-21' and content like '%班级视频'

insert into mcapp..stu_mc_day_raw_error (stuid,card,cdate,tw,zz,ta,toe,devid,gunid,kid,Status,adate,sendtime,ftype)
select stuid,card,cdate,tw,zz,ta,toe,'002408200','100001',24082,Status,adate,sendtime,0
 from mcapp..stu_mc_day_raw_error 
where kid=12511 and adate>='2016-01-14'



select LEN('2016-01-23 08:05:44.000')
 
;with cet as(
select  *,ROW_NUMBER() over( order by id) rawid
from mcapp..stu_mc_day_raw_error 
where kid=24082 and adate>='2016-01-14' -- and ID<=144930
)
--select dateadd(MI,rawid,cast(cdate as datetime)) d , convert(nvarchar(23),dateadd(MI,rawid,cast(cdate as datetime)),120) dd ,*
update c set cdate=convert(nvarchar(23),dateadd(MI,rawid,cast(cdate as datetime)),120)
 from cet c

select  *
--update r set ftype=0
from mcapp..stu_mc_day_raw_error  r
where kid=24082 and adate>='2016-01-14' and ftype=1

select  *
--delete
from mcapp..stu_mc_day_raw_temp  r
where kid=24082 and adate>='2016-01-14'

select  *
--delete r
from mcapp..stu_mc_day_raw  r
where kid=24082 and adate>='2016-01-14'

select *
--update a set status=2
from gbapp..archives_apply a where status=1

1301200002
1308000752
1303001741
select  *from basicdata..[user] where userid in(
653548,
653544,
567195)

select  *from mcapp..cardinfo c
 inner join basicdata..[user] u
  on c.userid=u.userid and u.usertype=0 and u.deletetag=1  where u.kid=12511 and u.userid>0

select * from mcapp..stu_mc_day_raw where kid =12511 and adate>'2016-01-23 16:00'
select * from mcapp..stu_mc_day_raw_error where kid =12511 and adate>'2016-01-23 16:00'
select * from mcapp..stu_mc_day where kid =12511 and adate>'2016-01-23'
select * from mcapp..mc_file_record where kid =12511 and crtdate>'2016-01-23 16:50' 
select * from mcapp..stu_mc_day where kid =12511 and adate>'2016-01-23 16:50'
select  *from mcapp..cardinfo where kid=12511 and userid>0
select  *from mcapp..cardinfo where card in('1301200002','1308000752','1303001741')

{"cmdid":"UploadStuAllData","serno":"201208240001","vcode":"91642d447d401974a6f09b7a5d804f80","date":"2012-08-24 08:00:00","devid":"001251101","dmcob":[{"stuid":295705,"card":"1301200002","cdate":"2016-01-23 08:05:00","tw":"38.2","zz":"1,2,3","ta":"25.1","toe":"35.6","gunid":"00125110101"},{"stuid":295706,"card":"1308000752","cdate":"2016-01-23 08:00:00","tw":"37.2","zz":"2,3","ta":"25.1","toe":"35.6","gunid":"00125110101"},{"stuid":295707,"card":"1303001741","cdate":"2013-08-25 08:08:00","tw":"37.2","zz":"5","ta":"25.1","toe":"35.6","gunid":"00125110101"}]}

http://98.mcgw.zgyey.com/uploadphoto.ashx/?uid=130156&clientid=12343&appver=1.084&client=1

001251111_653544_2016-01-23-17-12-23_张粒粒.jpg

select * from mcapp..mc_pic where kid = 12511 and userid= 653544

exec mcapp..MC_Photo_Detial_GetList 29497,35,-1,'','2016-01-01','2016-01-22',0

--create table mc_photo_url (id int primary key identity(1,1), url nvarchar(100),url2 nvarchar(100),net int)

--insert into mc_photo_url(url,url2,net)
--select 'http://98.mcgw.zgyey.com/photos','http://98.mcgw.zgyey.com/photos',98

--update mc_pic set net=118