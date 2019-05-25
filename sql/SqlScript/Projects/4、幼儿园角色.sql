select * from kwebcms..site where siteid=21666

select * from KWebCMS_Right..sac_org where org_id=17272

select * from KWebCMS_Right..sac_site_instance where org_id=17272

select * from KWebCMS_Right..sac_role where site_instance_id=16966

select * from KWebCMS_Right..sac_role_right where role_id=80624

--select * from KWebCMS_Right..sac_user_role

select * from BlogApp..permissionsetting where ptype=139 order by kid


   
--查询没有配置医生的幼儿园

select *
 from kwebcms..[site] s 
 inner join KWebCMS_Right..sac_org o
  on s.org_id=o.org_id
 inner join BasicData..kindergarten k
  on k.kid =s.siteid
   inner join BlogApp..permissionsetting p
  on p.kid =s.siteid and ptype=139
 inner join KWebCMS_Right..sac_site_instance i
  on i.org_id = o.org_id
 where not exists( select 1 from KWebCMS_Right..sac_role r
  where r.site_instance_id = i.site_instance_id and r.role_name like '%医生%')

--新增医生角色
 select * from KWebCMS_Right..sac_role where site_instance_id=16284 and role_id=84926
 select * from KWebCMS_Right..sac_role_right where role_id=84926

--5662	江西广电绿地山庄幼儿园
--31996	江西广电紫金城幼儿园
--23967	时光树幼儿园(演示用)
--6748	江西广电滨江豪园幼儿园
--31592	广电绿湖豪城幼儿园
--22188	莫幻测试专用，请勿删除


--给广西广电没有配置医生的都配上 医生角色

--siteid=27985

select 1 site_id,i.site_instance_id,'医生' role_name
 from kwebcms..[site] s 
 inner join KWebCMS_Right..sac_org o
  on s.org_id=o.org_id
 inner join BasicData..kindergarten k
  on k.kid =s.siteid
   inner join BlogApp..permissionsetting p
  on p.kid =s.siteid and ptype=139
 inner join KWebCMS_Right..sac_site_instance i
  on i.org_id = o.org_id
 where not exists( select 1 from KWebCMS_Right..sac_role r
  where r.site_instance_id = i.site_instance_id and r.role_name like '%医生%')
  
--给广西广电没有配置医生的都配上 医生角色(执行语句)
select 1 site_id,i.site_instance_id,'医生' role_name
 into #sac_role
 from kwebcms..[site] s 
 inner join KWebCMS_Right..sac_org o
  on s.org_id=o.org_id
 inner join BasicData..kindergarten k
  on k.kid =s.siteid
   inner join BlogApp..permissionsetting p
  on p.kid =s.siteid and ptype=139
 inner join KWebCMS_Right..sac_site_instance i
  on i.org_id = o.org_id
 where not exists( select 1 from KWebCMS_Right..sac_role r
  where r.site_instance_id = i.site_instance_id and r.role_name like '%医生%')

insert into KWebCMS_Right..sac_role(site_id,site_instance_id,role_name)
 select site_id,site_instance_id,role_name
  from #sac_role

insert into KWebCMS_Right..sac_role_right(role_id,right_id)
select r.role_id,rr.right_id
 from KWebCMS_Right..sac_role r
  inner join #sac_role tr
   on r.site_instance_id = tr.site_instance_id and r.role_name = '医生'
  cross join( select right_id from KWebCMS_Right..sac_role_right
   where role_id = 80624) rr
   
drop table #sac_role

-------------验证结果-----------------


--查询幼儿园角色权限     --是否已经分配的医生角色
select *
 from kwebcms..[site] s 
 inner join KWebCMS_Right..sac_org o
  on s.org_id=o.org_id
 inner join BasicData..kindergarten k
  on k.kid =s.siteid
  -- inner join BlogApp..permissionsetting p
  --on p.kid =s.siteid and ptype=139
 inner join KWebCMS_Right..sac_site_instance i
  on i.org_id = o.org_id
 inner join KWebCMS_Right..sac_role r
  on r.site_instance_id = i.site_instance_id and r.role_name like '%医生%'
 inner join KWebCMS_Right..sac_role_right rr
  on rr.role_id = r.role_id
  where s.siteid=20938 -- s.siteid=21666 


select * from kwebcms..site where siteid=27985
select * from KWebCMS_Right..sac_site_instance where org_id=23536
select * 
--delete r
from KWebCMS_Right..sac_role r where site_instance_id=23167 and role_name like '%医生%'
select * 
--delete r
from KWebCMS_Right..sac_role_right r
where role_id=84321




