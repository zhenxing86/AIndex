--Web App 消息
select * --delete
from sms..and_notice_detial where taskid=15

--update sms..and_notice_detial set status=1 where smsid>32

select * --delete  
from sms..and_notice_batch where taskid=14

--exec Send_And_Notice '测试xxx%stuname%xxx', 567195,'',',296418,296922',1,2,12511 
--exec Send_And_Notice '测试:%stuname%', 567195,'92233,','',0,2,12511 
 
--平台短信
select * --delete 
from sms..sms_batch where kid=12511 and sendtime>='2014-09-26' and taskid=245379

select ISNULL(smsnum,0) from KWebCMS.dbo.site_config where siteid = 12511  

select * from sms..sms_message_yx   where kid=12511 and sendtime>='2014-09-26' and taskid=245379
select * from sms..sms_message_ym   where kid=12511 and sendtime>='2014-09-26' and taskid=245377  (亿美会转移到sms_message_yx悦信)
select * from sms..sms_message_zy_ym  where kid=12511 and sendtime>='2014-09-26' and taskid=245377  
select * from sms..sms_message     where kid=12511 and sendtime>='2014-09-26' and taskid=245379
select * from sms..sms_message_temp     where kid=12511 and sendtime>='2014-09-26' and taskid=245377 
  
select *from basicdata..[User]  where userid in (444581,490019,295767,801385,801371)

select u.* from sms..and_notice_detial an
 inner join basicdata..[user] u
     on an.recuserid=u.userid and u.usertype=0
    inner join basicdata..user_class uc 
     on an.recuserid = uc.userid
    inner join basicdata..class c 
     on uc.cid= c.cid
    where an.taskid=11
    
    
--同步开通平台短信
select distinct kid into #kid from sms..sms_batch where sendtime>='2014-02-01'
--insert into blogapp..permissionsetting(ptype,kid)
select 100,kid 
from #kid where kid<>12511
drop table #kid

select *from blogapp..permissionsetting where ptype=100
