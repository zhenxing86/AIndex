use NGBApp
go
/*      
-- Author:      蔡杰    
-- Create date: 2014-04-10      
-- Description: 手机客户端获取幼儿表现数    
-- Memo:        Exec and_hb_class_GetList 46144, '2014-0'    
*/       
alter Procedure and_hb_class_GetList    
@cid Int,    
@term Varchar(50)    
as    
Set Nocount On    
    
Declare @kid Int    
Select @kid = kid From BasicData.dbo.class Where cid = @cid;    
    
With data as (    
Select e.pos, e.title, b.userid, c.diaryid,c.TeaPoint, ROW_NUMBER() Over(Partition by e.pos, e.title, a.gbid Order by c.diaryid Desc) RowNo    
  From NGBApp.dbo.growthbook a Left Join (Select pos, title From NGBApp.dbo.fn_GetCellsetList(@term, @kid)) e On 1 = 1    
                               Left Join Diary_Page_Cell c On a.gbid = c.gbid and e.pos = c.title,     
       BasicData.dbo.user_class_all b    
       inner join BasicData.dbo.[user] u on b.userid=u.userid and u.deletetag=1 and u.usertype=0  
  Where a.userid = b.userid and b.cid = @cid and a.term = @term and a.term=b.term and b.deletetag=1    
)    
Select pos, title, COUNT(Distinct userid) - 
SUM(Case When diaryid > 0 And TeaPoint<>'0,0,0,0,0,0,0,0' and TeaPoint<>'0,0,0,0,0,0,0,0,0,0' Then 1 Else 0 End) nowrite, 
SUM(Case When diaryid > 0 And TeaPoint<>'0,0,0,0,0,0,0,0' and TeaPoint<>'0,0,0,0,0,0,0,0,0,0' Then 1 Else 0 End) write    
  From data    
  Where RowNo = 1    
  Group by pos, title    
  Order by pos 