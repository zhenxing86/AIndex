use ossapp
go
/*     
-- Author:  xzx        
-- Project: com.zgyey.ossapp        
-- Create date: 2014-12-16      
-- Description: 判断天波设备编号是否存在        
   
tbdeviceinfo_Exist 1,'1301020102' 
   
*/           
CREATE PROCEDURE [dbo].[tbdeviceinfo_Exist]         
@tbid int,           
@tbdevid nvarchar(50)
AS          
BEGIN          
	if exists(select 1 from mcapp..tbdeviceinfo where tbdevid=@tbdevid and tbid <> @tbid and deletetag=1  )      
	begin        
		return 1     
	end     
	return 0       
END     
  
go