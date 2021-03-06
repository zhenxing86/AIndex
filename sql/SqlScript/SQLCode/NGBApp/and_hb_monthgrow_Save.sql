/*      
-- Author:      蔡杰    
-- Create date: 2014-04-15      
-- Description: 手机客户端保存每月进步    
-- Memo:        
*/       
CREATE Procedure and_hb_monthgrow_Save    
@userids Varchar(5000),    
@term Varchar(50),    
@pos Int,    
@MyPic  Varchar(200),    
@TeaWord NVarchar(2000)    
as    
    
Update a Set TeaWord = @TeaWord--, MyPic = @MyPic    
  From NGBApp.dbo.Diary_page_month_sec a, NGBApp.dbo.growthbook b    
  Where a.gbid = b.gbid and a.title = @pos and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term    
    
Insert Into NGBApp.dbo.Diary_page_month_sec(gbid, pagetplid, title, MyPic, TeaWord)    
  Select gbid, 3, @Pos, @MyPic, @TeaWord    
    From NGBApp.dbo.growthbook b    
    Where Not Exists(Select * From NGBApp.dbo.Diary_page_month_sec a     
                       Where a.gbid = b.gbid and a.title = @pos)    
      and b.userid In (Select col From BasicData.dbo.f_split(@userids,',')) and b.term = @term    