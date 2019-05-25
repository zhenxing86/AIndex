use ossapp
go
        
-- =============================================          
-- Author:  xzx          
-- Project: com.zgyey.ossapp          
-- Create date: 2013-06-08          
-- Description: 新增          
-- =============================================          
alter PROCEDURE [dbo].[deviceinfo_Exist]         
@id int,         
@devid nvarchar(9),           
@serialno nvarchar(50)       
AS          
BEGIN          
   if exists (select 1 from mcapp..driveinfo where serialno=@serialno and id<> @id and deletetag=1  )      
   begin        
 return -1        
   end        
   else if exists(select 1 from mcapp..driveinfo where devid=@devid and id <> @id and deletetag=1  )     
   begin        
 return -2        
   end      
   return 1        
END     
 
go