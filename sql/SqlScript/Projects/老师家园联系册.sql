/*
m.ls.jylx.zgyey.com
测试脚本

老师：account='ls' and userid=560725 and cname='托一班' and name='刘倩'
学生：account='jz' and userid=295767 and cname='托一班' and name='黄铭欣'
*/

/*测试要点：

1）学期寄语：图文版、纯文本
select * from ngbapp..moduleset where kid=12511 and term='2014-1'
2）模板：分正常缴费和未缴费（显示7条模板）
select * from ossapp..kinbaseinfo where status='正常缴费' and kid=12511

*/
--基础信息
select c.cname,u.usertype,u.* 
 from basicdata..[user] u
  inner join  basicdata..[user_class] uc 
   on u.userid=uc.userid 
  inner join basicdata..class c
   on uc.cid= c.cid
 where uc.cid=46144 and usertype = 1
 
 select *from basicdata..[user]where account='jz'
select *from basicdata..[User_Child] where account='jz'

ngbapp..GetGrowthBook 13828320,'qmzp'

SELECT *  
  FROM growthbook         
  WHERE gbid = 13828320    