use NGBApp
go
/*        
-- Author:      蔡杰      
-- Create date: 2014-04-15        
-- Description: 手机客户端获取观察与评价数据的日期      
-- Memo:          
*/         
alter Procedure and_hb_gcpj_Date_GetList      
@cid Int,      
@term Varchar(50)      
as      
      
Declare @kid Int      
Select @kid = kid From BasicData.dbo.class Where cid = @cid;      
      
With data as (      
Select e.pos, e.title, b.userid, c.diaryid,c.TeaPoint, ROW_NUMBER() Over(Partition by e.pos, e.title, a.gbid Order by c.diaryid Desc) RowNo      
  From NGBApp.dbo.growthbook a Left Join (Select pos, title From NGBApp.dbo.fn_GetMonAdvList(@term, @kid)) e On 1 = 1      
                               Left Join NGBApp.dbo.Diary_page_month_evl c On a.gbid = c.gbid and e.pos = c.months,       
       BasicData.dbo.user_class_all b      
  Where a.userid = b.userid and b.cid = @cid and a.term=b.term and a.term = @term and b.deletetag=1     
)      
Select pos, title, COUNT(Distinct userid) - 
SUM(Case When diaryid > 0 And TeaPoint<>'0,0,0,0,0,0,0,0' and TeaPoint<>'0,0,0,0,0,0,0,0,0,0' Then 1 Else 0 End) nowrite, 
SUM(Case When diaryid > 0 And TeaPoint<>'0,0,0,0,0,0,0,0' and TeaPoint<>'0,0,0,0,0,0,0,0,0,0' Then 1 Else 0 End) write      
  From data      
  Where RowNo = 1      
  Group by pos, title      
  Order by pos 