
'xzx113'

select * from BasicData..[USER] where account='xzx01'
select * from sms..audit_sms_batch where sender=1982145 and writetime>='2016-01-11'
select * from sms..sms_batch where sender=1982145 and writetime>='2016-01-11'
select * from sms..and_notice_batch where sender=1982145

select *  
-- update s set smsnum=10 
from kwebcms..site_config s where siteid=24082


p_material_List kmapp
CheckSmsValid 

 Select * From sms.dbo.IllegalKey 
 
 select * from audit_sms_batch where kid =24082 and writetime>='2016-01-11'
select * from sms_batch where kid =24082 and writetime>='2016-01-11'
select * from and_notice_batch where kid =24082 and writetime>='2016-01-11'

select * from  basicdata..[user] where userid=740793

°à¼¶Í¨Öª	²âÊÔ
2016-01-11PC Send Child Sms. NO.1000001
2016-01-11PC Send Child Sms.NO.1000003 SendTime2016-01-12 11:05
2016-01-11PC Send Child Notice NO.1000003 
--24082
select * from  basicdata..class where cid=97758
select smsnum,* 
--update s set smsnum=10
 from  KWebCMS..site_config s where siteid=24082   'xzx01' 1949969
 
exec rep_CurrentMonth_SMS_content 1,100,0,'2016-01-01', '2016-05-29',24082,867839,0 
exec [audit_CurrentMonth_SMS_content] 1,100,0,0,'2016-01-01', '2016-05-29',24082,867839,0      

 select * from basicdata..[USER_child] where kid=6274 order by name


select * into user_20160111_2 from basicdata..[USER] where kid=6274 and usertype=0 and deletetag=1

;with cet as(
select userid,account,mobile,name,
ROW_NUMBER() over (partition by mobile,name order by userid) rowid
  from basicdata..[USER] where kid=6274 and usertype=0 and deletetag=1  
),cet2 as(
select max(userid) userid,mobile
from cet c
where rowid=1 
group by mobile
)
select c.*,U.* 
--update u set u.account=c.mobile
from BasicData..[USER] u
 inner join cet2 c
  on u.userid=c.userid
  where u.account!=c.mobile and exists(
   select 1 from BasicData..[USER] u2 where u2.account=c.mobile)
  order by u.name
  
  
select c.*,U.* 
--update u set account=c.mobile,mobile=c.mobile
from BasicData..[USER] u
 inner join tem_user c
  on u.account=c.account and u.usertype=0 and u.deletetag=1
  where u.kid=6274 and not exists (select 1 from BasicData..[USER] u2 where u2.account=c.mobile)
  
select * from BasicData..[USER] u where account in(
'13360042983','13450201268','13711426757','15817171487','13711425461','13378452011'  'cjjz'
)
 
 
 
 