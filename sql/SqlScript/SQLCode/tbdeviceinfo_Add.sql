use ossapp
go
/*     
-- Author:  xzx        
-- Project: com.zgyey.ossapp        
-- Create date: 2014-12-16      
-- Description: 新增天波设备信息        
   
tbdeviceinfo_Add 12511 
   
*/      
CREATE PROCEDURE [dbo].[tbdeviceinfo_Add]            
@tbdevid nvarchar(50),        
@kid int,        
@ipaddress nvarchar(50),        
@port int,        
@exegroup int,        
@douserid int =0      
AS      
BEGIN  

insert into mcapp..tbdeviceinfo(tbdevid,kid,ipaddress,port,exegroup,deletetag)      
 values(@tbdevid,@kid,@ipaddress,@port,@exegroup,1)      
      
END      
    
go