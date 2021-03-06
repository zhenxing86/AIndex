use NGBApp
go 
/*      
-- Author:      xie  
-- Create date: 2014-04-15      
-- Description: 手机客户端发展评估用户列表(web)    
-- Memo:    
and_hb_dpg_GetListV2 80167, '2014-1'   
*/       
alter Procedure and_hb_dpg_GetListV2   
@cid Int,    
@term Varchar(50)    
as    
Select a.gbid, c.userid, c.name username, a.DevEvlPoint [desc]    
  From NGBApp.dbo.growthbook a, BasicData.dbo.user_class_all b, BasicData.dbo.[user] c    
  Where a.userid = b.userid and b.cid = @cid and b.term=a.term and a.term = @term and b.userid = c.userid and c.usertype=0 and b.deletetag=1        
  order by c.name    

