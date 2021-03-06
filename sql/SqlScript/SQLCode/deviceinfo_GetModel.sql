use ossapp
go      
-- =============================================    
-- Author:  xzx    
-- Project: com.zgyey.ossapp    
-- Create date: 2013-06-08    
-- Description: 根据id获取设备信息    
-- =============================================    
alter PROCEDURE [dbo].[deviceinfo_GetModel]    
@id int    
AS    
BEGIN    
    
 select devid,kid,sno,scode,maddr,saddr,adupt,msms,tsms,    
 psms,interval,wifi,photo,firmw,daddr,pcfirmw,pcdaddr,    
 serialno,id,showphoto,cardone,playcname,devicetype
    from mcapp..driveinfo     
    where id = @id    
END 

go