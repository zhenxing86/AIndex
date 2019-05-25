Use ClassApp
go
/*  
-- Author:      蔡杰
-- Create date: 2014-04-02  
-- Description: 班级公告消息推送
-- Memo:     
*/  
Alter TRIGGER Trg_class_schedule
   ON  dbo.class_schedule   
   AFTER INSERT  
AS   
Set NoCount On 

Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status)  
  Select Distinct i.kid, uc.userid, 1, 9, i.scheduleid, 1
    From Inserted i
      Inner Join BasicData..User_Child uc On i.kid  = uc.kid
    Where Exists(Select * From AndroidApp..and_userinfo au Where uc.userid = au.userid)
      and not exists (Select * From BasicData..MainPageList a 
                        Where a.userid = uc.userid and a.TagValue = i.scheduleid and a.Tag = 9 and a.Status = 1)

