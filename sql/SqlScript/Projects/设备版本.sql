


--设备类型：0：一体机，1：平板，2：MU260,3：晨检枪
 --publish_type :-1 废弃版，0：内测版，1：稳定版
 select * from mcapp..[device_version] where devicetype=3
 
 
 insert into device_version(devicetype,firmw,daddr,publish_time,crtdate,deletetag,publish_type)
 select 3,'pc_v3.5.4.1004','http://tmcgw.zgyey.com/version/pc_v3.5.4.1004.zip',GETDATE(),GETDATE(),1,0
 


 
select k.kid,k.kname,d.devid,d.serialno,dl.name,dl.dotime
from mcapp..driveinfo d
inner join BasicData..kindergarten k
 on d.kid=k.kid
outer apply(select top 1 name,dotime from mcapp..driveinfo_log l
left join ossapp..users u on l.douserid=u.ID
where l.devid=d.devid
order by l.id
) dl 
  where devicetype=1 and d.deletetag=1

select k.kid,k.kname,d.serialno,dl.name,dl.dotime
from mcapp..tcf_setting d
inner join BasicData..kindergarten k
 on d.kid=k.kid
outer apply(select top 1 name,dotime from mcapp..tcf_setting_log l
left join ossapp..users u on l.douserid=u.ID
where l.serialno=d.serialno
order by l.id
) dl 