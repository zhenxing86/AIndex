use mcapp
go
/*            
-- Author:      xie          
-- Create date: 2014-04-02            
-- Description: 获取所有幼儿园的正常短信发送权限           
-- Memo:              
      
exec kindergarten_GetList          
@kid =12512          
,@sendSet=1           
,@douserid =134        
      
update mcapp..kindergarten       
 set sendset=CommonFun.dbo.fn_RoleAdd(sendSet,3)      
where kid = 12511      
      
      
select sendSet,CommonFun.dbo.fn_RoleGet(sendSet,3),* from mcapp..kindergarten where kid =12511      
*/            
             
CREATE PROCEDURE [dbo].kindergarten_GetList       
 AS             
begin            
 set nocount on          
        
  select k.kid,CommonFun.dbo.fn_RoleGet(sendSet,3) a1,CommonFun.dbo.fn_RoleGet(sendSet,4) a2,CommonFun.dbo.fn_RoleGet(sendSet,5) a3    
   from mcapp..kindergarten k  
    inner join BlogApp..permissionsetting p     
     on p.kid =k.kid and p.ptype=90        
end 