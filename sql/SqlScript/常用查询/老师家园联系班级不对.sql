--[20865]井冈山市保育院老师反馈城东校区小三班尹丽珍老师

http://hbapp.up139.zgyey.com/AdminDefault.aspx?uid=700241
http://hbapp.up139.zgyey.com/defaultv5.aspx


----------获取老师的家园联系册-------------
ngbapp..GetHomeBookListByUserID
select h.hbid, h.term, ca.cname, h.cid           
from  HomeBook h            
 left join BasicData..class_all ca         
  on h.cid = ca.cid and h.term = ca.term     
   and ca.deletetag =1       
  left join basicdata..user_class_all uca         
   on ca.cid = uca.cid and ca.term = uca.term      
    and uca.deletetag =1          
where uca.userid = 700241     
--and h.term = @term            
 order by h.CrtDate desc 

-------------获取老师的班级，然后初始化所带班级的家园联系册------------------
select * from basicdata..[user_class] where userid=700241

----------家园联系册没有初始化 ngbapp..Init_GrowthBook 失败--------------
select * from HomeBook where cid in (select cid from basicdata..[user_class] where userid=700241)

----------该班级下没有小朋友，不会生成家园联系册--------------------------
select * from BasicData.dbo.User_Child where cid=163124
exec Init_GrowthBook 163124, '2013-1' 


管理员：
select * from BasicData..[user] where kid=20865 and name='尹丽珍'

select * from BasicData..[class] where cid=163124
select * from BasicData..[class_all] where cid=163124 
select * from BasicData..[user_class] where userid=700241
select * from BasicData..[user_class_all] where userid=700241

155777
163124
