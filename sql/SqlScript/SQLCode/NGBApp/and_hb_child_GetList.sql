use NGBApp
go
/*          
-- Author:      蔡杰        
-- Create date: 2014-04-10          
-- Description: 手机客户端获取幼儿表现数据        
-- Memo:        Exec and_hb_child_GetList 46144, '2014-0', 0        
*/           
alter Procedure and_hb_child_GetList        
@cid Int,        
@term Varchar(50),         
@pos Int        
as        
Set Nocount On        
        
Declare @kid Int        
Select @kid = kid From BasicData.dbo.class Where cid = @cid;        
        
With Data as (        
Select a.gbid, c.diaryid, e.name username, e.userid,
 Case When c.diaryid > 0 And c.TeaPoint<>'0,0,0,0,0,0,0,0' and c.TeaPoint<>'0,0,0,0,0,0,0,0,0,0' Then 1 Else 0 End status,         
       ROW_NUMBER() Over(Partition by a.gbid Order by c.diaryid Desc) RowNo        
  From NGBApp.dbo.growthbook a Left Join NGBApp.dbo.Diary_Page_Cell c On a.gbid = c.gbid and c.title = @pos,         
       BasicData.dbo.user_class_all b, BasicData.dbo.[user] e        
  Where a.userid = b.userid and b.cid = @cid and b.term=a.term and a.term = @term and b.userid = e.userid and e.usertype=0 and b.deletetag=1      
)        
Select diaryid, username, userid, status From Data Where RowNo = 1 order by username 