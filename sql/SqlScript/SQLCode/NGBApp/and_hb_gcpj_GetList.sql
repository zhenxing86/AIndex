use NGBApp
go
/*      
-- Author:      蔡杰    
-- Create date: 2014-04-15      
-- Description: 手机客户端获取观察与评价数据    
-- Memo:    

and_hb_gcpj_GetList 80167, '2014-1',0       
*/       
alter Procedure and_hb_gcpj_GetList    
@cid Int,    
@term Varchar(50),     
@pos Int    
as    
    
Declare @kid Int    
Select @kid = kid From BasicData.dbo.class Where cid = @cid    
Select target From NGBApp.dbo.monthtarget     
  Where grade In (Select b.gtype From BasicData.dbo.class a, BasicData.dbo.grade b     
                    Where a.grade = b.gid and a.cid = @cid)     
    and months In (Select Months From NGBApp.dbo.fn_GetMonAdvList(@term, @kid) Where pos = @pos)    
  Order by orderno;    
    
With Data as (    
Select a.gbid, c.diaryid, e.name username, e.userid, Case When c.diaryid > 0 Then 1 Else 0 End status, c.TeaPoint, c.ParPoint,    
       ROW_NUMBER() Over(Partition by a.gbid Order by c.diaryid Desc) RowNo    
  From NGBApp.dbo.growthbook a Left Join NGBApp.dbo.Diary_page_month_evl c On a.gbid = c.gbid and c.months = @pos,     
       BasicData.dbo.user_class_all b, BasicData.dbo.[user] e    
  Where --a.userid = b.userid and b.cid = @cid and a.term = @term and b.userid = e.userid and a.term=b.term 
  a.userid = b.userid and b.cid = @cid and b.term=a.term and a.term = @term and b.userid = e.userid and e.usertype=0 and b.deletetag=1      
)    
Select diaryid, username, userid, status, TeaPoint, ParPoint From Data Where RowNo = 1 order by username