use PayApp
go

select *
--update f set deletetag=0
 from ossapp..[payinfolog] f where kid=23294 and id=8689
 
------获取需要绑定的套餐 feetype_dict_GetList---------
SELECT feetype,name,[from],remarks FROM feetype_dict where bind_vip =1 

---------------设置开通阅读权限的人-------------------
--ossapp..users_read_Exist  --326,343,361,365,374,375,392
SELECT * 
--delete ur
FROM ossapp..users_read ur 
 inner join ossapp..users u on ur.userid = u.ID
 where u.ID not in(326,374)

insert into ossapp..users_read(userid)values(361)

select * from ossapp..users u where name='杨秋莲'
select * from ossapp..users u where ID in(326,343,361,365,374,375,392)
 
 
------自动开通vip 操作记录  （新增的用户，自动开通VIP）在客服工具的自动开VIP设置----------
ossapp..addservice_vip_Add_auto_update

select * from ossapp..addservice_vip_Add_auto_update_log l
 inner join ossapp..users u on l.douserid=u.id where kid=20581
 
---------自动vip延期（除阅读外）---------------
--ossapp..addservice_vip_Add_renewal_getlog
--ossapp..addservice_vip_Add_renewal

