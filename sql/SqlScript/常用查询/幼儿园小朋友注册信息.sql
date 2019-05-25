[36365]永宁镇芙蓉幼儿园 [36364]万春第一幼儿园@谢振兴 
麻烦帮我导出这两家园的幼儿资料的注册时间，导出的表里面要有班级、姓名、注册时间。


select c.cname,u.name,u.regdatetime 
from BasicData..[user] u
 inner join BasicData..user_class uc on u.userid=uc.userid
 inner join BasicData..class c on uc.cid=c.cid
 where u.kid=36364

