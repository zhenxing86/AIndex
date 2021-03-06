/*    
-- Author:      蔡杰  
-- Create date: 2014-04-15    
-- Description: 手机客户端保存观察与评价  
-- Memo:      
*/     
CREATE Procedure and_hb_gcpj_Save  
@userids Varchar(5000),   
@term Varchar(50),   
@Pos Int,  
@TeaPoint Varchar(50)  
as  
  
--Merge NGBApp.dbo.Diary_page_month_evl a  
--Using NGBApp.dbo.growthbook b On a.gbid = b.gbid and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term  
--When Matched and a.months = @pos Then  
--  Update Set a.TeaPoint = @TeaPoint  
--When Not Matched Then   
--  Insert (gbid, pagetplid, months, TeaPoint) Values(b.gbid, @pagetplid, @Pos, @TeaPoint);  
  
Update a Set TeaPoint = @TeaPoint  
  From NGBApp.dbo.Diary_page_month_evl a, NGBApp.dbo.growthbook b  
  Where a.gbid = b.gbid and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term  
  
Insert Into NGBApp.dbo.Diary_page_month_evl(gbid, pagetplid, months, TeaPoint, ParPoint)  
  Select gbid, 4, @Pos, @TeaPoint, '0,0,0,0,0,0,0,0,0'  
    From NGBApp.dbo.growthbook b  
    Where Not Exists(Select * From NGBApp.dbo.Diary_page_month_evl a   
                       Where a.gbid = b.gbid and a.months = @pos)  
      and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term  
  