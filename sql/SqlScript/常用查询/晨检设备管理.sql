
--麻烦帮我查下 这个平板号：085235380017 


select l.serialno 系列号,l.devid,l.kid,l.douserid,u.name 操作人,l.dotime 操作时间,l.ipaddress IP地址
 from mcapp..driveinfo_log l
  left join ossapp..users u on l.douserid=u.ID
   where serialno='085235380017' order by l.id
   


select l.serialno 系列号,l.kid,l.douserid,u.name 操作人,l.dotime 操作时间,l.ipaddress IP地址
 from mcapp..tcf_setting_log l
  left join ossapp..users u on l.douserid=u.ID
   where serialno='13088294' order by l.id
   
   
16011046、16011048 谢谢
------------------------------------------

-- '3010173400004'
 
 --删除闸机

 select * 
 --delete
 from mcapp..gate_device where kid=35417 and sn='DDG7020087012100411'
 select * 
 --delete
 from mcapp..gate_timezones_device where sn='DDG7020087012100411'
