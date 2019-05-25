--1体温偏高 2咳嗽 3喉咙发炎 4流鼻涕 5皮疹 6腹泻 7红眼病 8重点观察 9剪指甲 10服药提醒 11家长带回 

--1、晨检幼儿园
select sendSet,* from mcapp..kindergarten where kid =12511
--2、入园、离园都要配置了  
select * from blogapp..permissionsetting where [ptype]=113 and kid=28277  
select * from applogs..permissionsetting_log where [ptype]=113 and kid=28277  
--logdata..sitelog_add("ID为" + kid + "的幼儿园设置开启" + str, UserID
select * from logdata..site_log where describe like 'ID为28277的幼儿园设置%班级圈'

--3、晨检短信套餐
select *
--update a set a7=806,describe='开通',pname='套餐4',vippaystate=1,ftime=getdate(), ltime=dateadd(year,1,getdate())
 from ossapp..addservice a where uid =653612
 
 ;WITH CET AS          
 (          
  select distinct kid    from sms..sms_message_curmonth where smstype=14 and writetime>='2015-09-11'  
  union    
  SELECT distinct kid           
   FROM sms..sms_message_yx_temp  --悦信（全部） 
    where smstype=14 and writetime>='2015-09-11' 
 )            
select k.kid,case when c.kid>0 then 1 else 0 end '入园短信'
 from mcapp..kindergarten k
 inner join BlogApp..permissionsetting p
  on k.kid = p.kid and ptype=90
 left join CET c
  on k.kid = c.kid
  order by k.kid
  
--4、刷卡记录
SELECT * from mcapp..stu_mc_day d
 inner join BasicData..User_Child uc
  on d.stuid=uc.userid
   where d.kid =18208 and convert(varchar(10),cdate,120)='2017-05-17' and zz<>''
   and sms_zz<>''
   
   '18922209598jz'

select * from BasicData..User_Child where kid=30869 and name='刘梓岐'
select * from mcapp..cardinfo where userid=2161919
select * from mcapp..stu_mc_day where kid=30869 and convert(varchar(10),cdate,120)='2017-05-16' and card='1608030401'
select * from mcapp..stu_mc_day_raw where kid=30869 and convert(varchar(10),cdate,120)='2017-05-16' and card='1608030401'

select * from AppLogs..mc_log   
  where kid = 18208 and crtdate>='2015-12-10'  and userid = 9684868  
  
select *from mcapp..stu_mc_day d
 left join mcapp..sms_mc s
  on s.recuserid = d.stuid  and s.writetime>='2015-12-10'
 where d.cdate>='2015-12-10' and d.cdate<='2015-12-10' and sms_zz='2' and s.guid is null order by s.recuserid

select *from mcapp..stu_mc_day d
 left join mcapp..push_mc s
  on s.userid = d.stuid  and s.writetime>='2015-12-10'
 where d.cdate>='2015-12-10' and sms_zz='2' and s.userid is null order by s.userid

select *from mcapp..push_mc where kid=18208 and  writetime>='2015-12-10' 

select * from BasicData..[USER] where userid=9684868 1560523

permissionsetting_update ossapp
select * from applogs..permissionsetting_log where [ptype]=113 and kid=28277     

update BasicData..[user] set mobile='13632432093' where userid=653612 and kid= 12511
select a7,*from BasicData..[user] u
left join ossapp..addservice a on a.uid=u.userid
where u.userid=802913 and u.kid =12511


select * from mcapp..sms_mc where writetime>='2015-09-16' 
select COUNT(1) from mcapp..stu_mc_day where adate>='2015-09-16' and ftype=1 
select * from mcapp..sms_mc where writetime>='2015-09-16 9:00' 
select * from mcapp..push_mc where writetime>='2015-09-16 9:00' 


玄武：
[SMS].[dbo].[sms_message] --玄武中转表，运营商扫描该表进行发送短信，
发送成功后，将记录转移到sms..sms_message_curmonth，
并将一个月前的转移到历史表sms_history..sms_message。

悦信：
[旧的]sms..sms_message_zy_ym 临时表。会转移到[SMS].[dbo].[sms_message_yx]
[SMS].[dbo].[sms_message_yx] --悦信中转表，运营商扫描该表进行发送短信

【现在】 直接放到待发表 [sms_message_yx]  status=10
 insert into sms..sms_message_yx(recMObile,Status,content,SendTime,Kid, Cid,WriteTime, sender,recuserid)        
    select '13632432093',10,'测试悦信通道:'+ convert(varchar(21),getdate(),120) ,getdate(),20675,118993,getdate(),0,0    
    
发送成功后，将记录转移到sms..sms_message_yx_temp--悦信（全部）


--发送后的，历史表：
sms..sms_message_curmonth --玄武       
sms..sms_message_yx_temp  --悦信（全部）
sms_history..sms_message --玄武历史 

目前，
1)晨检异常短信（含正常短信），都由玄武发送。即从临时表mcapp..sms_mc到[SMS].[dbo].[sms_message]
2)幼儿园网站注册验证码短信，都由悦信发送。即从临时表basicdata..verify_sms 到[SMS].[dbo].[sms_message_yx] 
select top 10 * from mcapp..sms_mc 
where sendtime>='2014-04-08' and
kid = 22120 order by sendtime desc

老师短信   8,10,11   (要配置主班老师)
select * from mcapp..sms_man_kid where kid = 12511

select top 100 * from mcapp..sms_mc 
where kid = 21398 and 
sendtime>='2014-04-02' and
--content like '%家长带回%' and 
--content like '%校医%' and
--recuserid = 626286 and
recmobile = '15167910635'

--2)如果sendtime有值，看status是不是等于11
select * from sms..sms_message_yx_temp where kid=21398 and sendtime>='2014-04-02' and recmobile='13786123167'
select *from sms..sms_message_yx_temp where kd

--3)不是status=11，让客服查询 是否有发送出现。
select c.cardno,a7,uc.mobile,a.* from ossapp..addservice a 
left join mcapp..cardinfo c on a.[uid]=c.userid
left join BasicData..User_Child uc on c.userid=uc.userid
where  a.kid =20154 
and a.[uid]=636327
and c.cardno='1308019978'

 select * from applogs.dbo.EditLog
--园长短信
晨检短信（有症状才发）
select top 1000 * from sms..sms_message_yx_temp where recmobile='15279019919' 
select top 1000 * from sms..sms_message_curmonth where recmobile='15279019919' 

 select *
   --update y set status=11
    from sms..[sms_message_yx] y  where  status=9
  select * from sms..sms_message_zy_ym   where  status=9 and writetime>='2016-03-30'
   
  sms..sms_message_yx_temp 
  
  select * from sms..sms_batch where taskid=581124
  
  select * from sms..sms_batch where sender=90529 and writetime>='2016-03-30' and smscontent='明天（3月31日）早上我园将为大班级的幼儿拍毕业照，请小朋友按时回园，没有特殊情况不要请假，服装和鞋子不作要求。谢谢配合！' taskid=581124
  
  select * from sms..sms_batch where taskid=581124
  
  select * from sms..sms_message_zy_ym   where  status=13
  
   select * from sms..sms_message_zy_ym s where recmobile='13503028808' and writetime>='2016-03-30'
   
   select * from sms..sms_message_ym s where recmobile='13503028808' and writetime>='2016-03-30'