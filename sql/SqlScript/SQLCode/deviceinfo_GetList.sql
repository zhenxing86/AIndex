use ossapp
go
-- =============================================        
-- Author:  xzx        
-- Project: com.zgyey.ossapp        
-- Create date: 2013-06-08        
-- Description: 获取幼儿园设备信息        
/*    
deviceinfo_GetList 12511    
*/    
-- =============================================        
alter PROCEDURE [dbo].[deviceinfo_GetList]        
@kid int        
AS        
BEGIN        
    
 if(@kid=-1)    
  select devid,kid,sno,scode,maddr,saddr,adupt,msms,tsms,        
         psms,interval,wifi,photo,firmw,daddr,pcfirmw,    
         pcdaddr,serialno,id,showphoto,cardone,playcname,devicetype    
   from mcapp..driveinfo   
    where devicetype=0 and showphoto=1 and deletetag=1  
   order by kid    
 else     
  select devid,kid,sno,scode,maddr,saddr,adupt,msms,tsms,        
         psms,interval,wifi,photo,firmw,daddr,pcfirmw,    
         pcdaddr,serialno,id,showphoto,cardone,playcname,devicetype      
   from mcapp..driveinfo            
   where kid = @kid and deletetag=1       
END     
    
go