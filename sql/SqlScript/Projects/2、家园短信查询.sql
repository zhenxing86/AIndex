use sms
go

/*  2018-01-01起，不再使用玄武短信，只是用悦信和又拍，又拍的短信  */
----SMS..upyun_message_getlist_by_mobile '13632432093' 又拍消息发送记录----

SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms..sms_message_curmonth --玄武(当月)
   --where taskid >=475098 and taskid<=475107
   where taskid >=475139 and taskid<=475142
       
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms..sms_message_yx_temp  --悦信（全部）
   where taskid =475098 
   
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms_history..sms_message --玄武历史
    where taskid =475098 
    
  select userid,mobile,vars content,writetime,* from sms..sms_message_upyun where template_id=837 --又拍
  select * from sms..sms_message_upyun_history --又拍历史
    
--短息
select *from sms_batch sb where sender=883473 and kid=23713 and sb.sendtime >= '2015-09-07'
  and sb.sendtime < '2015-09-10'

--消息 
select *from dbo.and_notice_batch sb where sender=883473 and kid=23713 and sb.sendtime >= '2015-09-07'
  and sb.sendtime < '2015-09-10'
               
--非全园发送的幼儿园，删除非VIP的小朋友                                      
select COUNT(1)  from KWebCMS..site_config where isvipcontrol=1 and siteid=2367
 
------------------当月家长短信记录------------------------------
--1) 汇总
/*
sms..rep_CurrentMonth_SMS_content 当月
--sendtype 0:按小朋友 1:按老师,2:按年级,3:按班级,4:按部门,5:按职位
*/
--select u.name, sb.smscontent, sb.sendtime, sum(sb.Sendusercount) Sendusercount,SUM(sb.sendsmscount) sendsmscount, sb.sendtype, MIN(sb.taskid) taskid,sb.appsend
select u.name 发送人, sb.smscontent 发送内容, sb.sendtime 发送时间, sum(sb.Sendusercount) 接收人数,SUM(sb.sendsmscount) 短信数量, 
case sb.sendtype when 0 then '按小朋友' when 1 then '按老师' when 2 then '按年级' when 3 then '按班级' when 4 then '按部门' when 5 then '按职位' end 发送对象        
   from sms_batch sb      
     inner join BasicData..[user] u      
     on sb.sender = u.userid      
   where sb.kid = 4246  and sb.kid=u.kid    
     and sb.sendtime >= '2018-05-01'
     and sb.sendtime < '2018-06-01' 
     and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = 0    
     and sb.cid <> 0      
GROUP BY u.name, sb.smscontent, sb.sendtime, sb.sendtype,sb.appsend 

--2）明细
;with cet as(    
  select taskid,recuserid,recmobile,content,sendtime from sms..sms_message_yx_temp where kid=4246 and sendtime>='2018-05-01' and sendtime < '2018-06-01'  
)  
SELECT u.name as username, sm.recmobile,sm.content,sm.sendtime    
 from cet sm    
  inner join BasicData..[user] u     
   on sm.recuserid = u.userid and u.usertype=0 
       
----------------当月老师短信记录--------------------------
-- 1）汇总
--select u.name, sb.smscontent, sb.sendtime, sb.Sendusercount,sb.sendsmscount, sb.sendtype, sb.taskid,sb.appsend
select u.name 发送人, sb.smscontent 发送内容, sb.sendtime 发送时间, sb.Sendusercount 接收人数,sb.sendsmscount 短信数量, 
case sb.sendtype when 0 then '按小朋友' when 1 then '按老师' when 2 then '按年级' when 3 then '按班级' when 4 then '按部门' when 5 then '按职位' end 发送对象      
 from sms..sms_batch sb      
   inner join BasicData..[user] u      
   on sb.sender = u.userid      
 where sb.kid = 4246 and sb.kid=u.kid       
     and sb.sendtime >= '2018-05-01'
     and sb.sendtime < '2018-06-01'  
   and CASE WHEN GETDATE() > sb.sendtime THEN 0 ELSE 1 end = 0      
   and sb.cid = 0
   
--2）明细
select sb.cid, c.cname, COUNT(1) sendnum, SUM(Case When sb.sendsmscount > sb.Sendusercount Then sb.sendsmscount End) as LongSMS,   
   SUM(Case When sb.sendsmscount <= sb.Sendusercount Then sb.Sendusercount End) as ShortSMS, SUM(sb.sendsmscount) paynum    
from sms..sms_batch sb  
 inner join BasicData.dbo.class c  
  on sb.cid = c.cid  
where sb.sendtime >= '2018-05-01' 
 AND sb.sendtime < '2018-06-01' 
 and sb.kid = 4246  
GROUP BY sb.cid, c.cname  


;with cet as(  
  select taskid,recuserid,recmobile,content,sendtime from sms..sms_message_yx_temp where kid=4246 and sendtime>='2018-05-01' and sendtime < '2018-06-01'  
)  
SELECT u.name as username, sm.recmobile,sm.content,sm.sendtime    
 from cet sm    
  inner join BasicData..[user] u     
   on sm.recuserid = u.userid and u.usertype>0
   
