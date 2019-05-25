use ossapp
go
/* 
-- Author:  xzx    
-- Project: com.zgyey.ossapp    
-- Create date: 2013-06-08    
-- Description: 根据id获取设备信息    

tbdeviceinfo_GetModel 1

*/    
CREATE PROCEDURE [dbo].[tbdeviceinfo_GetModel]    
@tbid int    
AS    
BEGIN    
    
 select tbid,tbdevid,kid,ipaddress,port,exegroup     
    from mcapp..tbdeviceinfo     
    where tbid = @tbid    
END    
  
go