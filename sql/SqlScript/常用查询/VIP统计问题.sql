

select * from ossapp.dbo.feestandard where kid=28267
select * from ossapp.dbo.feestandard f
 inner join ossapp..dict b on f.a1 = b.ID and b.name = '服务类型'
  --and b.deletetag = 1  
  where kid=28267


select a.*, c.cname as 班级,          
       u.name as 姓名,          
       u.mobile as 电话,          
       convert(varchar(10),a.ftime,120) as 开始时间,          
       convert(varchar(10),a.ltime,120) as 结束时间,          
       a.pname 套餐,convert(varchar(10),a.dotime,120) 操作时间          
  from basicdata..[user] u          
 inner join basicdata..user_class uc on uc.userid=u.userid and u.usertype=0          
 inner join basicdata..class c on c.cid=uc.cid          
 inner join ossapp..addservice a on a.[uid]=u.userid and u.kid=a.kid          
 inner join basicdata..grade g on g.gid=c.grade          
 where            
  a.kid=28267 and a.uid=2497054       
  and a.deletetag=1          
  and a.describe='开通'          
  and u.deletetag=1          
  and c.grade<>38--不需要毕业班的          
  order by g.[order] asc,c.[order] asc    
  
  select * from ossapp..dict where name = '套餐名称'
  
  
  --select * from ossapp..dict where name = '服务类型'
  