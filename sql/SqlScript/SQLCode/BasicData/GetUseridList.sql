use BasicData
go
/*        
-- Author:      xie  
-- Create date: 2014-09-19       
-- Description: 过程用于根据cid集合获取对应的小朋友列表        
-- Paradef:         
-- Memo:  

GetUseridList 80166
   
*/    
alter proc GetUseridList  
@reccid varchar(8000)  
 as  
 begin  
  select distinct uc.userid  --将输入字符串转换为列表        
   from BasicData.dbo.f_split(@reccid,',') c  
    inner join BasicData..user_class uc  
     on c.col=uc.cid  
    inner join basicdata..[user] u  
     on uc.userid=u.userid and u.usertype=0  
      and u.kid>0 and u.deletetag=1  
 end  