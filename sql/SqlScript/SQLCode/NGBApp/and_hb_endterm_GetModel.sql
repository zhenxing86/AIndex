use NGBApp
go
/*      
-- Author:      蔡杰    
-- Create date: 2014-04-15      
-- Description: 手机客户端获取期末总评的数据    
-- Memo:  
   and_hb_endterm_GetModel 80167, '2014-1'   
*/       
alter Procedure and_hb_endterm_GetModel    
@cid Int,    
@term NVarchar(2000)    
as    
    
Select a.gbid, c.userid, c.name username, Cast(Case When Isnull(a.TeaWord, '') <> '' Then 1 Else 0 End as Int) [status],     
       TeaWord, Height, Weight, Eye, Blood, Tooth, DocWord    
  From NGBApp.dbo.growthbook a, BasicData.dbo.user_class_all b, BasicData.dbo.[user] c    
  Where a.userid = b.userid and b.cid = @cid and b.term=a.term and a.term = @term and b.userid = c.userid and c.usertype=0 and b.deletetag=1 
  order by c.name    