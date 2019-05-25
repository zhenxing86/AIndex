USE NGBapp
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master̷
-- Create date: 2013-12-20 
-- Description:	
-- Memo: 		
*/
Alter TRIGGER Trg_Page_Cell  
   ON  dbo.Page_Cell 
   AFTER INSERT
AS 
BEGIN
 if @@RowCount <= 0 Return                  
 set nocount on    
  INSERT INTO BasicData..MainPageList(kid, userid, type, Tag, TagValue, Status)  
   select Distinct gb.kid, gb.userid, 2, 2, 2, 1  
    FROM inserted i   
     inner join diary d   
      on i.diaryid = d.diaryid  
     inner join growthbook gb   
      on d.gbid = gb.gbid   
    where exists(select 1 from AndroidApp..and_userinfo au where gb.userid = au.userid)  
      and Not Exists(Select * From BasicData..MainPageList a
                       Where a.userid = gb.userid and a.Tag = 2 and a.TagValue = 2)
END
GO