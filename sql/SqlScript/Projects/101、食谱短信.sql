 测试脚本    
    
[Send_Recipe_SMS_by]    
update kwebcms..recipe_sms set status=0,sendusercount=0,sendsmscount=0,xuanwu=0, yimei=0, xian=0 where rec_sms_id=65    
    
update kwebcms..recipe_sms set status=0,sendusercount=0,sendsmscount=0,siteid=12511,sendtime='2015-10-15 08:00:00.000',xuanwu=0, yimei=0, xian=0 where rec_sms_id=64    
    
         
     
 declare @bgntime datetime,@endtime varchar(10),    
  @rec_sms_id int,@siteid int,@categoryid int,@contentid int,@title nvarchar(50),@sendtime datetime,@content varchar(5000)    
 select @bgntime=getdate()    
 select @endtime=convert(varchar(10),dateadd(dd,1,getdate()),120)    
select @bgntime,@endtime,rec_sms_id, siteid,categoryid,contentid,title,sendtime,content    
 from kwebcms..recipe_sms where sendtime>=@bgntime and sendtime<@endtime and deletetag=1 and status=0    
    
delete sms..sms_message_temp_test       
delete KWebCMS..recipe_sms_error   
delete kwebcms..recipe where rid= 25  
    
select *from sms..sms_message_temp_test  t    
 inner join BasicData..[User] uc    
  on t.recuserid= uc.userid and uc.kid = 12511    
   and uc.deletetag=1 and uc.usertype=0     
    
select top 10 *   
--delete   
from kwebcms..cms_content where categoryid= 86089   and new_recipe=1  and siteid=23967 and createdatetime>='2015-10-16 18:40'  
  
update c set smsnum = 100 from KWebCMS.dbo.site_config  c  where siteid = 24082     
update c set smsnum = 3546 from KWebCMS.dbo.site_config  c  where siteid = 24082  

  --vip 权限控制  
   select * from KWebCMS..site_config where isvipcontrol=1                           
   and siteid=23967      
     
  --开通了vip的用户,手机号格式，幼儿园短信数量，食谱上传时间、上传时间、星期一时间设置。 
   select * from basicdata..[user] u  
    inner join BasicData.dbo.Child d                           
     on d.userid=u.userid and u.kid=23967 and u.deletetag=1 and u.usertype=0     
     and commonfun.dbo.fn_cellphone(u.mobile) = 1                       
   where ISNULL(d.vipstatus,0) = 1  
   
 --短信数量
select * from KWebCMS.dbo.site_config  c  where siteid =24082  

--发送消息
  select * from kwebcms..recipe where siteid=24082 and startdate>='2015-11-09' and status=1
--发送消息
  select * from kwebcms..recipe_sms where siteid=20345 and createdatetime>='2015-11-09' and deletetag=1 --and status=1
  order by sendtime
  
--失败记录
  select * from kwebcms..recipe_sms_error where  siteid=24082 and createdatetime>='2015-10-16'
   select * from kwebcms..recipe_sms where sendtime>='2015-11-12' and sendtime<'2015-11-13' and deletetag=1
   select * from kwebcms..recipe where createdatetime>='2015-11-01' 
--短信查询
 ;WITH CET AS        
 (        
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms..sms_message_curmonth --玄武
   where kid= 24082 and sendtime>='2015-11-15'    
  UNION ALL        
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms..sms_message_yx_temp  --悦信（全部）
   where kid= 24082 and sendtime>='2015-11-15'  
  UNION ALL  
  SELECT recuserid,recmobile,content,sendtime,status,writetime         
   FROM sms_history..sms_message --玄武历史 
   where kid= 24082 and sendtime>='2015-11-15'  
 )          
  select *
   from CET        
   --where recuserid=@userid          
   order by sendtime desc 
   
   
/*
select top 10 *   
--delete   
from kwebcms..cms_content where categoryid= 86089   and new_recipe=1  and siteid=24082 and createdatetime>='2015-11-09'  
  
delete from kwebcms..recipe_sms where siteid=24082 and createdatetime>='2015-11-09' 
delete from kwebcms..recipe where siteid=24082 and createdatetime>='2015-11-09' 


delete from sms..sms_message_temp where sender=867839 and kid=24082 --and taskid in(520782,520783)

select * from KWebCMS.dbo.site_config  c  where siteid =24082  
select * from sms..sms_batch where sender=867839
select * from basicdata..[user] where account='13976016027'
select * from kwebcms..recipe_sms_error where siteid=24082 AND  createdatetime>='2015-11-07' and deletetag=1 order by deletetag,sendtime
  
*/



select * from kwebcms..recipe_sms where siteid=26224 and createdatetime>='2015-11-09' 
select * from sms..sms_batch where taskid in( 521036,521037,521038,521039,521040,521041,521042)
select * from KWebCMS.dbo.site_config  c  where siteid =26224  

select update sms..sms_batch set recobjid = '108107,108108,108109,108987,123117,123340,123341' ,sendtype=3 where taskid in( 521036,521037,521038,521039,521040,521041,521042)


--------------------------食谱导入有问题排查--------------------------------------
select * from KWebCMS..cms_content where contentid=522835
select * from KWebCMS..cms_content where contentid=522813
select * from KWebCMS..cms_content where contentid=522798
select * from recipe where contentid=522798

insert into recipe(
siteid,contentid,title,style,startdate,rec_types,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday,createdatetime,status,
categoryid,deletetag,updatetime,douserid,sendsms,senddate,currentweek,offset)
select siteid,522813,'美好童年幼儿园10月份第二周食谱',style,startdate,rec_types,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday,createdatetime,status,
categoryid,deletetag,updatetime,douserid,sendsms,senddate,currentweek,offset from recipe where contentid=522798


select * from KWebCMS..cms_content where contentid=522813
select * from recipe where contentid=522798


