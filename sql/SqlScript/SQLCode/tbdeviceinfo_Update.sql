use ossapp
go
/*      
-- Author:  xzx        
-- Project: com.zgyey.ossapp        
-- Create date: 2014-12-16     
-- Description: 更新天波设备信息        

tbdeviceinfo_Update 

*/      
alter PROCEDURE [dbo].[tbdeviceinfo_Update]  
@tbid int,       
@tbdevid nvarchar(50),        
@kid int,        
@ipaddress nvarchar(50),        
@port int,        
@exegroup int,        
@douserid int =0     
AS        
BEGIN        
        
 update mcapp..tbdeviceinfo         
  set tbdevid=@tbdevid,kid=@kid,ipaddress=@ipaddress,port=@port,exegroup=@exegroup   
   where tbid = @tbid        
         
END   

go