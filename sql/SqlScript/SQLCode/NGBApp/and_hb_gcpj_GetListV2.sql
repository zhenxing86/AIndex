use NGBApp
go
/*            
-- Author:      xie        
-- Create date: 2014-10-24          
-- Description: 手机客户端获取观察与评价数据(Web)         
-- Memo:   BasicData.dbo.class where kid=12511     
     
and_hb_gcpj_GetListV2 80167, '2014-1', 0    
          
*/             
alter Procedure and_hb_gcpj_GetListV2          
@cid Int,          
@term Varchar(50),           
@pos Int          
as          
          
;With Data as (          
Select a.gbid, c.diaryid, e.name username, e.userid,
 Case When c.diaryid > 0 And c.TeaPoint<>'0,0,0,0,0,0,0,0' and c.TeaPoint<>'0,0,0,0,0,0,0,0,0,0'  Then 1 Else 0 End status,        
 isnull(c.TeaPoint,'0,0,0,0,0,0,0,0,0') TeaPoint, isnull(c.ParPoint,'0,0,0,0,0,0,0,0,0') ParPoint,          
       ROW_NUMBER() Over(Partition by a.gbid Order by c.diaryid Desc) RowNo          
  From NGBApp.dbo.growthbook a Left Join NGBApp.dbo.Diary_page_month_evl c On a.gbid = c.gbid and c.months = @pos,           
       BasicData.dbo.user_class_all b, BasicData.dbo.[user] e          
  Where --a.userid = b.userid and b.cid = @cid and a.term = @term and b.userid = e.userid and e.usertype=0    
  a.userid = b.userid and b.cid = @cid and b.term=a.term and a.term = @term and b.userid = e.userid and e.usertype=0 and b.deletetag=1          
)          
Select diaryid, username, userid, status, TeaPoint, ParPoint From Data Where RowNo = 1 order by username