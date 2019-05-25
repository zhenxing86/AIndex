
--正常的权限
kwebcms..site_menu_GetMenuListByParentID 134134,9777

--新增权限
;with cet as(
SELECT distinct sac_role_right.right_id,60629 role_id--DISTINCT sac_right.right_id,right_code  
FROM sac_user_role   
INNER JOIN sac_role_right ON sac_user_role.role_id=sac_role_right.role_id  
INNER JOIN sac_right ON sac_role_right.right_id=sac_right.right_id  
WHERE [user_id]=89068
)
--insert into sac_role_right(role_id,right_id)
select role_id,right_id from cet 
where not exists(
 select * from sac_role_right SM 
  where cet.right_id =sm.right_id and sm.role_id=cet.role_id and sm.role_id=60629)

--删除多余权限
SELECT sac_role_right.*--DISTINCT sac_right.right_id,right_code  
--delete sac_role_right
FROM sac_user_role   
INNER JOIN sac_role_right ON sac_user_role.role_id=sac_role_right.role_id  
INNER JOIN sac_right ON sac_role_right.right_id=sac_right.right_id  
WHERE [user_id] in(13333,13334)  and sac_right.right_id in (3,7,10,21)

SELECT distinct sac_user_role.role_id
FROM sac_user_role   
INNER JOIN sac_role_right ON sac_user_role.role_id=sac_role_right.role_id  
INNER JOIN sac_right ON sac_role_right.right_id=sac_right.right_id  
WHERE [user_id]=38833

38832,13335,38833,    (60629)13333,13334
