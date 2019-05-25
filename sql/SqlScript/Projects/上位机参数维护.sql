

deviceinfo_GetModel
deviceinfo_Update
deviceinfo_Add


mcapp..driveinfo
ossapp

alter table mcapp..driveinfo add account varchar(50)
alter table mcapp..driveinfo add password varchar(100)
alter table mcapp..driveinfo_log add account varchar(50)
alter table mcapp..driveinfo_log add password varchar(100)

select *from ossapp..users where ID>=238

;with logs as
(
select * from mcapp..driveinfo_log l where  douserid=238 and dotime>'2015-06-11 10:09:18.163' and id in
 ( 
 select Min(id)  from  mcapp..driveinfo_log g
  where douserid=238 and dotime>'2015-06-11 10:09:18.163'
   group by devid
)
)
select d.firmw,l.firmw,d.daddr,l.daddr,d.pcfirmw,l.pcfirmw, d.pcdaddr,l.pcdaddr
--update d set firmw=l.firmw,daddr=l.daddr,pcfirmw=l.pcfirmw, pcdaddr=l.pcdaddr
from mcapp..driveinfo d
 inner join logs l
  on d.devid=l.devid and d.deletetag=1
  
  --select *from mcapp..driveinfo where kid= 
  




