--------------------------------
--(所有注册了时光树的老师)  kmapp..push_hx_add
--action:63
--标题：元旦祝福
--内容：给孩子们送上节日祝福吧！   --'chhlls' 'xzx113'
Select u.userid, b.relationship      
  Into #hx_user
  --select COUNT(1)    
  From kmapp..[km_user] u,kmapp.dbo.user_relationship b                  
  Where u.userid=b.userid and u.deletetag=1 and u.role in(0,1)
   and b.hxregtag = 1 --and u.kid=21666 -- and b.userid in (1982145)  --( 740793,1562355,862869,1982145,1438841,1968678) 
   --and exists(select 1 from kmapp.dbo.login_record l where adddate>='2015-08-10' and u.userid=l.userid)   
   
--环信推送             
Declare @phid bigint               
Insert Into kmapp.dbo.push_hx(userid, title, content, url, status, adddate, action, sendtype, sourceid)                    
  Select 0, '节日祝福提醒', '给孩子们送上节日祝福吧！',                   
        'http://ydscene.zgyey.com/Communicate/NewYear/?hxuid={hxuid}&kid={kid}&uid={uid}&client={client}&appver={appver}&key={key}',                   
        0, getdate(), 51, 0, 0                  
           
Select @phid = scope_identity()                    



 
 select * from kmapp.dbo.push_hx_history where phid = 29047
 
34686,34686
                
Insert Into kmapp.dbo.push_hx_user(phid, userid, relationship)                    
  Select Distinct @phid, userid, relationship                    
    From #hx_user    

select * from kmapp.dbo.push_hx where phid=29047  @phid  --   29029  29046(21666)   --29047(正式)
drop table #hx_user  


select * from  push_hx_user p
 inner join basicdata..[user] u on p.userid=u.userid where phid=29035
 
--update kmapp.dbo.push_hx set adddate='2015-12-28'  where phid=29029
select * from kmapp.dbo.push_hx where title='节日祝福提醒' and action=51 and adddate>='2015-12-28' order by adddate desc
select * from kmapp.dbo.push_hx where  title='元旦祝福' and action=51 and adddate>='2015-12-28 19:10' order by adddate desc,phid desc  --1458882
	
select * 
--update px set adddate='2015-12-29' 
from kmapp.dbo.push_hx px
 inner join BasicData..[user] u
  on px.userid = u.userid
 where  u.kid=24082 and title='元旦祝福' and action=51 and adddate>='2015-12-28 19:40' order by phid desc

--select count( userid) from kmapp.dbo.user_relationship b where hxstatus = 1

select * from kmapp.dbo.push_hx_history where  userid=1982145 and action=51 
select * from kmapp.dbo.push_hx where userid=0 and action=51 order by phid desc
Select * From LogData.dbo.hx_log Where phid = 29047 and touid =34686,34686
select * from kmapp.dbo.push_hx_history where phid = 29047
logdata..hx_log
http://lydscene.zgyey.com/Communicate/NewYear?hxuid=1982145a1&client=1&content=
http://lydscene.zgyey.com//Communicate/NewYear_Show?recordid=6616&uid=1949968

Select * 
--delete r
From kmapp..push_hx_add_record r      
  inner join kmapp..km_user k       
   on r.uid = k.userid      
  left join kmapp..templet t       
   on r.templetid = t.templetid       
  where k.kid=21666 and title='元旦祝福' -- and uid= 1982145 -- id=@recordid    
  order by ID desc  


 select u.account,u.password, uc.* from basicdata..[USER] u
  inner join basicdata..[user_class] uc on u.userid=uc.userid
   where  u.kid=28277 and u.usertype=1
   
 select * from basicdata..[user_child] u where kid=28277 and cid=116482
  select * from basicdata..[user_class] u where  userid=1458882
  
--查询发送记录
;with cet as(   
select phid from kmapp.dbo.push_hx where title='节日祝福提醒' and action=51 and adddate>='2015-12-28' --order by adddate desc
)
select * from  kmapp..push_hx_user p
 inner join basicdata..[user] u on p.userid=u.userid 
 inner join cet c on p.phid=c.phid and u.userid=1481209  --1458893

select * from kmapp.dbo.push_hx where phid =29029
SELECT TOP 1000 *  FROM [logdata].[dbo].[hx_log] where phid=29029 and dotime>='2015-12-28' and touid=1458893

select * from kmapp..login_record  where userid = 1481209
  
  '13750441348ls'
  
  select * from kmapp..user_relationship where userid=1481209
  select * from kmapp..user_relationship where userid=1458893