use MqktApp
go


select t.name 模块, bc.cname 兴趣班, uc.cname 后台班级,uc.name 姓名,answers 答案
from mqktapp..theme_answer a
 inner join BasicData..User_Child uc on a.userid=uc.userid
 inner join mqktapp..theme t on t.id=a.themeid
 inner join mqktapp..base_class bc on bc.mqcid=t.mqcid
 where uc.kid=31650
 
 
 select bc.cname 兴趣班,t.*
from mqktapp..theme t
 inner join mqktapp..base_class bc on bc.mqcid=t.mqcid
 where t.kid=31650
 
select bc.*,d.* 
--update d set deletetag=1
from mcapp..driveinfo d
 inner join mqktapp..base_class bc on bc.mqcid=d.mqcid
  where bc.kid=31650 and bc.mqcid>0 and d.deletetag=0
 
 select * 
 --update bc set cname=''
 from mqktapp..base_class bc where kid=31650 and cname='小人国'

update bc set cname='奇妙的影子' from mqktapp..base_class bc where kid=31650 and cname='小人国'
update bc set cname='灌篮高手' from mqktapp..base_class bc where kid=31650 and cname='有趣的泡泡'
update bc set cname='动物图书馆' from mqktapp..base_class bc where kid=31650 and cname='幼儿园图书馆'

update bc set cname='动物报' from mqktapp..base_class bc where kid=31650 and cname='动物图书馆'

动物报
 
1 奇妙的影子  2 灌篮高手  3 动物图书馆

2	小人国
3	有趣的泡泡
4	幼儿园图书馆
5	神奇多米诺
6	我型我秀
7	有趣的泡泡

