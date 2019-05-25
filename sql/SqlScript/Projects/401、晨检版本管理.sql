
--设备类型：0：一体机，1：平板，2：MU260,3：晨检枪
--版本类型：-1 废弃版，0：内测版，1：稳定版
select * from mcapp..device_version order by devicetype,firmw


select * from mcapp..device_version where devicetype=3 and id=94
select * from mcapp..device_version where devicetype=3 and id=119




insert into mcapp..device_version(devicetype,firmw,daddr,publish_time,crtdate,deletetag,publish_type)
select devicetype,'pc_v3.5.5.1001','http://mcgw.pc118.zgyey.com/version/pc_v3.5.4.1004.zip',GETDATE(),GETDATE(),deletetag,0
 from mcapp..device_version where devicetype=3 and id=94

insert into mcapp..device_version(devicetype,firmw,daddr,publish_time,crtdate,deletetag,publish_type)
select devicetype,'pc_v4.0.20','http://mcgw.pc118.zgyey.com/version/pc_v4.0.20.zip',GETDATE(),GETDATE(),deletetag,0 
from mcapp..device_version where devicetype=3 and id=119