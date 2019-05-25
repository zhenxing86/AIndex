
--补班级相册的动态
kmapp..km_postTwitterForClassPhoto_Add
--km_postTwitterForClassPhoto_Add 483064,620444,55002,'http://img2.yeyimg.com/','http://img2.yeyimg.com/','http://img2.yeyimg.com/','http://img2.yeyimg.com/',''   

14527吉贝尔国际幼儿园大一班老师15837128206上传了相片，管理员在班级圈那里不到更新动态18737133516


--[20938]江西广播电视艺术幼儿园  揭凌燕老师	'13699537776'	反馈近期时光树上传班级相册，没有显示在班级圈的动态里面。
2117758

select * from classapp..class_photos where albumid=932005

 select  classid ,*              
  from classapp..class_album                
   where albumid =932005
   
select * from BasicData..class where cid =143506
select * from BasicData..user_class where userid=2117758 and cid =143506

kmapp..km_getGroupTwitters 483064,55002,100,1 
http://img2.yeyimg.com/ClassAttachsFiles/20150923//5bedf21e-5824-4524-abec-c6ad31511666_small.jpg,http://img2.yeyimg.com/ClassAttachsFiles/20150923//685fa595-948c-4f83-85d7-3229b984eeb0_small.jpg,http://img2.yeyimg.com/ClassAttachsFiles/20150923//7959f5d9-e0f3-45ca-a776-eaf31558e826_small.jpg
Select *                                               
  From kmapp.dbo.twitter t                          
    left join BasicData..[user] u                          
      on t.userid = u.userid                    
    left join kmapp..km_user k                     
      on t.userid = k.userid                  
  Where t.deletetag = 1                          
    --and t.cid = 55002 
    and u.userid= 2117758 
    order by t.adddate
    
Select *                                               


select * from kmapp.dbo.twitter t where twrid in (   111922,129296,129298) 
update kmapp.dbo.twitter set content='刘一妹在《哇，好香》相册上传了照片' where twrid =129298


select  *from BasicData..[user] where account='15837128206'
select  *from BasicData..[user_class] where userid=483064
select  *from BasicData..[class] where cid=55002
select   * from BasicData..[user] where userid= 883911
select   * from BasicData..user_bloguser  where bloguserid= 823933

http://m.class.zgyey.com/33298/scheduleview_s719124.html

update kmapp..twitter  set deletetag =1 where twrid =62373
    --教学安排 http://m.class.zgyey.com/33298/scheduleview_s710514.html  cid= 33298,scheduleid = 710514
select * from classapp..class_schedule where  scheduleid = 719124

--select  content=u2.name +'发了教学安排',ub.userid, ub.*, t.*
----update t set content= u2.name +'发了教学安排',userid= u2.userid 
--from dbo.twitter t  
--left join BasicData..[user] u                          
--      on t.userid = u.userid   
--      inner join BasicData..user_bloguser ub                          
--      on t.userid = ub.bloguserid 
--      inner join BasicData..[user] u2                          
--      on ub.userid = u2.userid     
--  Where t.deletetag = 1 and t.ftype=3                         
--    --and t.cid = 33298 and  t.userid=883911 and t.content =''  and u.name is null
--    and u.userid is null and ub.userid>0 order by adddate  
    
-- twitter 的userid 传的是bloguserid的问题。
select  u2.userid,u2.name,t.*
--update t set content= u2.name +'发了教学安排',userid= u2.userid 
 from kmapp.dbo.twitter t 
inner join basicdata..class c
 on t.cid = c.cid 
left join BasicData..[user] u
 on t.userid =u.userid and u.kid =c.kid
 
 inner join BasicData..user_bloguser ub                          
      on t.userid = ub.bloguserid 
      inner join BasicData..[user] u2                          
      on ub.userid = u2.userid and c.kid=u2.kid
      
 where t.ftype=3 and u.userid is null
 and t.cid =3036


select COUNT(1) -- content=u2.name +'发了教学安排', t.*
from kmapp.dbo.twitter t
      left join BasicData..[user] u2                          
      on t.userid = u2.userid
      left join BasicData..user_class uc2
       on u2.userid = uc2.userid and t.cid = uc2.cid       
  Where t.deletetag = 1 and t.ftype=3                         
    --and t.cid = 33298 and  t.userid=883911 and t.content =''  and u.name is null
    and uc2.userid is null and  t.cid = 33298  order by adddate
    
    
    select * into twitter0916 from kmapp.dbo.twitter
    
    



 
 
