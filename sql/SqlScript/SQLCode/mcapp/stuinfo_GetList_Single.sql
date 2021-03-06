use mcapp
go
/*        
-- Author:      xie      
-- Create date: 2013-10-26        
-- Description: 根据kid、cid获取用户基础信息      
-- Memo:          
exec mcapp..stuinfo_GetList_Single -1,19536       
*/               
CREATE PROCEDURE stuinfo_GetList_Single          
 @cid int,        
 @kid int       
 AS        
BEGIN        
 SET NOCOUNT ON         
            
  IF @cid <> -1       
  begin      
 select u.userid,name,uc.cid,c.cname cname,u.usertype,c.grade from       
   BasicData..[user] u   
    left join BasicData..[user_class] uc  
     on u.userid=uc.userid  
     left join BasicData..[class] c  
     on uc.cid=c.cid  
    where u.kid = @kid and uc.cid= @cid      
  end      
  else      
  begin      
 select u.userid,name,uc.cid,c.cname cname,u.usertype,c.grade  
  from BasicData..[user] u   
    left join BasicData..[user_class] uc  
     on u.userid=uc.userid  
     left join BasicData..[class] c  
     on uc.cid=c.cid  
    where u.kid = @kid   
  end      
        
 end      