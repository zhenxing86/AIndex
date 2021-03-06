USE [KWebCMS_Right]
GO
Get_KWebCMS_Right_site 21666


select si.org_id,si.site_instance_id,si.site_instance_name,si.site_id,s.siteid,s.name,s.sitedns
from kwebcms.dbo.[site] s 
inner join sac_site_instance si on s.org_id=si.org_id and si.site_id=1
where --t1.siteid=@kid
si.site_instance_id = 23437

--[right_GetRolesList] @site_id =1,@site_instance_id =23437
SELECT role_id,site_id,site_instance_id,role_name
FROM sac_role
WHERE site_id=1 AND site_instance_id=23437

select *from sac_role where role_name like '%医生%' order by role_id desc
select * from sac_site_instance where site_instance_name = '满天星幼儿园'   --无记录

select sr.role_id,sr.role_name, si.org_id,si.site_instance_id,si.site_instance_name,si.site_id,s.siteid,s.name,s.sitedns
from kwebcms.dbo.[site] s 
inner join sac_site_instance si on s.org_id=si.org_id --and site_id=1
inner join sac_role sr on sr.site_id = si.site_id and sr.site_instance_id=si.site_instance_id
where s.siteid=21666 and
si.site_instance_id in( 
16966
)
order by s.siteid

site_instance_id    kid			kname
21826				26632	满天星幼儿园
17507				22231	满天星幼儿园
16966				21666	满天星幼儿园

--新增角色

[dbo].[right_CreateRole] @site_id =1,@site_instance_id =16966,@role_name ='医生'

INSERT INTO sac_role(site_id,site_instance_id,role_name)
VALUES(@site_id,@site_instance_id,@role_name)
RETURN @@IDENTITY

select site_instance_name,*from sac_site_instance  where site_instance_id=16966
select * delete from sac_role where site_instance_id=16966 and role_id=80623


select site_instance_name,*
update s set site_instance_name = '满天星幼儿园网站后台1' from sac_site_instance s  where site_instance_id in(21826,17507)
	
	
http://mcphoto.yey.com
http://mcphoto.yey.com

select * from mcapp..mc_photo_url


