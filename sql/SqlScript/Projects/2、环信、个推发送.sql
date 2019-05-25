Select b.name From Syscomments a, sysobjects b Where TEXT Like '%sms_message_zy_ym%' and a.id = b.id

kmapp..Tri_subscription on subscription
[push_group_addTosingle]  --预览图文消息
[push_group_addbymtid]  --群发图文
push_group_add_bycontent  --群发文本、视频

select *from [push_content] where publicid=40 
select *from [material] where publicid=40 
from push_message_history where publicid=40 

select * 
--delete
 from kmapp..demo_kindergarten where kid = 24082
insert into kmapp..demo_kindergarten (kid) values( 24082)

--没用过时光树的, 不会给他发时光树的消息

--环信发送
SELECT TOP 1000 *  FROM [logdata].[dbo].[hx_log]

--推送日志 
SELECT TOP 1000 *  FROM [kmapp].[dbo].[push_log]

--时光树登录日志
select * from kmapp..login_record  where userid = 1458893

18925265135    '18922209598ls'

--环信注册日志
select * from kmapp..hxreglog where userid = 1592365

--环信消息发送
select * from logdata.dbo.hx_log

--公众号消息推送
select * from  kmapp..push_message_history where userid = 1597286

select * from kmapp.dbo.push_hx where sourceid =10379
select * from kmapp.dbo.push_hx_user where phid=20917 and userid=1525008
select * from kmapp.dbo.push_log where userid=1525008 order by intime desc  --个推 推送记录表
select * from LogData.dbo.hx_log where touid=919578 order by dotime desc  --环信推送记录表
select * from kmapp..user_relationship where userid=1525008


--环信日志查询
select phid into #phid from kmapp.dbo.push_hx_history where userid=0 and title='节日祝福提醒'
select * from kmapp.dbo.push_hx_user_history p
 inner join #phid h on p.phid=h.phid
 where p.userid =33653  --接收人
 
Select * From LogData.dbo.hx_log Where phid = 29047 and touid In (34686, 33653)


select * from  kmapp..push_message_history where userid =33653


ID:29486  有个家长从9月份开始到现在一直没收到过老师通过APP发送的班级通知，麻烦查一下是什么原因。家长账号是：18925265135。发通知的老师账号是：13642495465
select * from sms..and_notice_batch where sender =1510018 and sendtime>='2015-10-20'
select * from sms..and_notice_detial where sender =1510018 and recuserid=1525008 and sendtime>='2015-10-20'


select * from 
[dbo].[push_content] c        
   inner join  dbo.publics p        
    on c.publicid=p.publicid and p.deletetag =1 and c.deletetag =1        
   left join material m       
    on c.mtid=m.mtid    
    
select * from [push_content] where publicid=3 and adddate>='2015-11-19'
select * from push_message_history where publicid=3 and adddate>='2015-11-19'

--select * from BasicData..[user] where kid=23967 and account ='cjjz'
--select * from BasicData..[user] where kid=23967 and usertype>
select * from BasicData..[user] where account ='18925265135'

18028633611jz 1458901
18028633611ls 1458895
18028633611yz 1458878






--------------------------------
(所有注册了时光树的活跃用户)
--action:63
--标题：版本更新通知
--内容：时光树最新版本升级啦！
Select u.userid, b.relationship      
  Into #hx_user
  --select COUNT(1)    
  From BasicData..[user] u,kmapp.dbo.user_relationship b                  
  Where u.userid=b.userid and u.deletetag=1
   and b.hxregtag = 1 and b.userid in( 862909) 
   --and exists(select 1 from kmapp.dbo.login_record l where adddate>='2015-08-10' and u.userid=l.userid)   
 
--环信推送                  
Declare @phid bigint               
Insert Into kmapp.dbo.push_hx(userid, title, content, url, status, adddate, action, sendtype, sourceid)                    
  Select 0, '版本更新通知', '时光树最新版本升级啦！',                   
        'http://pmv.zgyey.com/TimetreeMsg/Content?cid=169',                   
        0, getdate(), 63, 0, 0                  
                  
Select @phid = scope_identity()                    
                    
Insert Into kmapp.dbo.push_hx_user(phid, userid, relationship)                    
  Select Distinct @phid, userid, relationship                    
    From #hx_user    
    
drop table #hx_user
--select count( userid) from kmapp.dbo.user_relationship b where hxstatus = 1

select COUNT(1) from kmapp..login_record where adddate>'2015-05-10'
select COUNT(1) from kmapp..login_record where adddate>'2015-05-10'


(所有注册了时光树的活跃用户，并开通了晨检的园长)
--标题：健康服务信息
--内容：给园长的一封信！
--action:64

Select u.userid, b.relationship      
  Into #hx_user
  --select COUNT(1)    
  From BasicData..[app_user] u,kmapp.dbo.user_relationship b                  
  Where u.userid=b.userid and u.deletetag=1 and u.role=0
   and b.hxregtag = 1 --and b.userid in( 1458878) 
   and exists(select 1 from kmapp.dbo.login_record l where adddate>='2015-08-10' and u.userid=l.userid) 
   and exists(select 1 from BlogApp..[permissionsetting] p where p.kid =u.kid and p.ptype=90)   

    
--环信推送                  
Declare @phid bigint               
Insert Into kmapp.dbo.push_hx(userid, title, content, url, status, adddate, action, sendtype, sourceid)                    
  Select 0, '健康服务信息', '给园长的一封信！',                   
        'http://pmv.zgyey.com/TimetreeMsg/Content?cid=168',                   
        0, getdate(), 64, 0, 0                  
                    
Select @phid = scope_identity()                    
                    
Insert Into kmapp.dbo.push_hx_user(phid, userid, relationship)                    
  Select Distinct @phid, userid, relationship                    
    From #hx_user    
    
drop table #hx_user



(所有注册了时光树的活跃用户，并开通了晨检和健康服务的家长)
----家长action=64
--标题：健康服务信息
--内容：给家长的一封信！
--图片：http://img2.yeyimg.com/TimeTree/20150909/055dc109-3b59-49a3-89b1-cbffbe510642_small.jpg
--url:http://pmv.zgyey.com/TimetreeMsg/Content?cid=107
  

Select u.userid, b.relationship      
  Into #hx_user
  --select COUNT(1)    
  From BasicData..[user] u,kmapp.dbo.user_relationship b                  
  Where u.userid=b.userid and u.deletetag=1 and u.usertype=0
   and b.hxregtag = 1 --and b.userid in( 1458901) 
   and exists(select 1 from kmapp.dbo.login_record l where adddate>='2015-08-10' and u.userid=l.userid) 
   and exists(select 1 from BlogApp..[permissionsetting] p where p.kid =u.kid and p.ptype=90)   
   and exists(select 1 from ossapp..addservice a where a.uid =u.userid and a.describe='开通' and a9>0)
   and u.kid in(28277,12511)

--select * from basicdata..[user] where userid=1458901  
--环信推送                  
Declare @phid bigint               
Insert Into kmapp.dbo.push_hx(userid, title, content, url, status, adddate, action, sendtype, sourceid)                    
  Select 0, '健康服务信息', '给家长的一封信！',                   
        'http://pmv.zgyey.com/TimetreeMsg/Content?cid=107',                   
        0, getdate(), 64, 0, 0                  
                    
Select @phid = scope_identity()                    
                    
Insert Into kmapp.dbo.push_hx_user(phid, userid, relationship)                    
  Select Distinct @phid, userid, relationship                    
    From #hx_user    
    
drop table #hx_user
--select COUNT(1) from kmapp.dbo.push_hx where action=64
--select COUNT(1) from kmapp.dbo.user_sys_message where action=65

--个推
--Insert Into kmapp.dbo.user_sys_message(userid, msgtype, content, status, adddate, action, title, url)    
  --Select userid, 5, @name + '发了【' + @smstitle + '】', 0, GETDATE(), 62, @smstitle,     
  --       'http://srv.zgyey.com/sms/SendMessage/NoticeView/?hxuid={hxuid}&client={client}&kid={kid}&uid={uid}&client={client}&appver={appver}&key={key}'    
  --  From #receiver    
  --  Where userid not IN (Select userid From #hx_user)  
  
  
  
--[个推] 疫苗推送、
declare @userid int
declare @name varchar(20)
set @userid = 1458901   
set @name = (select name from BasicData..[user] where userid = @userid)

Insert Into kmapp..push_message(userid, publicid, pcid, msgtype, status, action, pctype, title, content, url, file_url,typeid)
 select @userid,18,0,5,0,1,0,'幼儿疫苗接种情况填写提醒','亲爱的' +@name+'家长您好：'+char(10) + char(13) + char(13) + char(13) + char(13)+'疫苗接种是提高幼儿免疫力、预防疾病的重要途径之一，我们将根据孩子的年龄和疫苗接种的历史记录，定时提醒您接种疫苗并为您提供预防接种的指导建议。'+char(10) + char(13) + char(13) + char(13) + char(13)+
'请您及时填写幼儿的疫苗接种历史记录，谢谢您对我们工作的支持。',
           'http://srv.zgyey.com/jkzx/Vaccine/Index?kid=0&uid='+cast(@userid as varchar(14))+'&key=dfh_eoi_439','',3 
           
Insert Into kmapp..push_message(userid, publicid, pcid, msgtype, status, action, pctype, title, content, url, file_url,typeid)
 select @userid,18,0,5,0,1,0,'幼儿过敏史及遗传病史填写提醒','亲爱的' +@name+'家长您好：'+char(10) + char(13) + char(13) + char(13) + char(13)+'为了让孩子拥有健康的身体，每一个细节我们都不能忽略，我们需要对幼儿的健康情况有足够的了解和认知，才能为他的健康发展提供更好的帮助。'+char(10) + char(13) + char(13) + char(13) + char(13)+
'请您及时填写幼儿过敏史、遗传病史等幼儿健康资料，让我们的保育医生和带班老师对您的孩子有更细致的了解，更好的照顾您的孩子。',
           'http://srv.zgyey.com/jkzx/HealthData/Index?kid=0&uid='+cast(@userid as varchar(14))+'&key=dfh_eoi_439','',3  
           
           
--[个推] 幼儿健康服务包
select *from BasicData..[USER] where account='18028633611jz' and deletetag=1

create table #k(userid int)
insert into #k(userid)
select distinct u.userid 
  from BasicData..[user] u
   left join BlogApp..[permissionsetting] p
       on u.kid = p.kid 
 where  p.ptype=90 
     and exists(select 1 from kmapp.dbo.login_record l where adddate>='2015-08-10' and u.userid=l.userid)
     and exists(select 1 from ossapp..addservice a where a.uid =u.userid and a.describe='开通' and a9>0)
     and u.usertype = 0
     and u.deletetag  = 1
      

--Insert Into kmapp..push_message(userid, publicid, pcid, msgtype, status, action, pctype, title, content, url, file_url,typeid)
 select userid,18,0,4,0,1,0,'幼儿健康服务包','为什么宝宝刚上幼儿园容易生病？生病了又应该怎么护理？还有很多很多关于宝宝健康方面的知识和小工具。这些，宝妈们都知道吗？答案就在时光树健康服务包里，快来瞧瞧吧！',
           'http://sgs.pay.zgyey.com/pay/index?kid={kid}&client={client}&appver={appver}&uid={uid}','http://pmv.zgyey.com/html/jkfw/cover.jpg',3     
    from #k 
