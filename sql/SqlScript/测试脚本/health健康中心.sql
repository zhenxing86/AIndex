use healthapp
go 
/*  
  
-- Author:  xie       
-- Create date: 2014-08-29        
-- Description: 获取健康档案的权限  
  
healthapp  
demo:  
*/  
  
alter proc hc_Get_VipStatus  
@userid int  
  
as  
begin  
 select case when a.ftime<=GETDATE() And a.ltime>=GETDATE() then a.a9 else 0 end a9   
 from ossapp..addservice a where a.deletetag=1 and a.[uid]=@userid and a.describe='开通' -- and a.vippaystate=1  这 
end