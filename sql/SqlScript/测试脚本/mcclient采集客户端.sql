
--mcclient/mu260

--二代设置为 “不开VIP可开卡”
--insert into BlogApp..permissionsetting(ptype,kid)
select 70,kid from mcapp..driveinfo d where devid like '%30' 
and not exists( select * from BlogApp..permissionsetting p where d.kid=p.kid)
