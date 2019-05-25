use ossapp
go
/*     
-- Author:  xzx        
-- Project: com.zgyey.ossapp        
-- Create date: 2014-12-16      
-- Description: 获取天波设备信息        
   
tbdeviceinfo_GetList 12511 
   
*/    
-- =============================================        
CREATE PROCEDURE [dbo].[tbdeviceinfo_GetList]        
@kid int        
AS        
BEGIN      
  select tbid,tbdevid,kid,ipaddress,port,exegroup     
   from mcapp..tbdeviceinfo            
   where kid = @kid and deletetag=1       
END     
    
go