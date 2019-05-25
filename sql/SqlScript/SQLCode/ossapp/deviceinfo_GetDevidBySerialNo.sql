  use mcapp
  go
-- =============================================  
-- Author:  xzx  
-- Project: com.zgyey.ossapp  
-- Create date: 2013-06-08  
-- Description: ÐÂÔö  
deviceinfo_GetDevidBySerialNo '001251112'
-- =============================================  
create PROCEDURE [dbo].[deviceinfo_GetDevidBySerialNo]  
@serialno nvarchar(50)  
AS  
BEGIN  
  
 select top 1 devid   
 from mcapp..driveinfo   
 where serialno=@serialno  
  
END