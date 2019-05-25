Use ClassApp
go
/*  
-- Author:      蔡杰
-- Create date: 2014-04-02  
-- Description: 班级公告消息推送
-- Memo:     
*/  
Alter TRIGGER Trg_class_notice_class
   ON  dbo.class_notice_class   
   AFTER INSERT  
AS   
Set NoCount On 

Insert Into BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status)  
  Select Distinct cn.kid, uc.userid, 1, 8, cn.noticeid, 1
    From Inserted i
      Inner Join dbo.class_notice cn On i.noticeid = cn.noticeid
      Inner Join BasicData..User_Child uc On cn.kid  = uc.kid and i.classID = uc.cid
    Where Exists(Select * From AndroidApp..and_userinfo au Where uc.userid = au.userid)
      and not exists (Select * From BasicData..MainPageList a 
                        Where a.userid = uc.userid and a.TagValue = cn.noticeid and a.Tag = 8 and a.Status = 1)

