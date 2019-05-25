  -- =============================================  
-- Author:  xzx  
-- Project: com.zgyey.ossapp  
-- Create date: 2013-06-08  
-- Description: 更新设备信息  
-- =============================================  
create PROCEDURE [dbo].[deviceinfo_UpdateVersion]  
@devid nvarchar(9),  
@firmw nvarchar(150),  
@daddr nvarchar(150),  
@pcfirmw nvarchar(150),  
@pcdaddr nvarchar(150),
@vtype int --0:固件版本，1：pc端版本
AS  
BEGIN  
  
if(@vtype=0)
 update mcapp..driveinfo   
 set firmw=@firmw,daddr=@daddr
    where devid = @devid  
else if(@vtype=1)
	update mcapp..driveinfo   
	 set pcfirmw=@pcfirmw,pcdaddr=@pcdaddr
		where devid = @devid  
      
 exec config_manage_Update 9,1  --更新缓存
END  


cardinfo_getlist_all