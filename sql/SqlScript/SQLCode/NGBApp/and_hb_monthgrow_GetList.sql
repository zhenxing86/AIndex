USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[and_hb_monthgrow_GetList]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
-- Author:      蔡杰  
-- Create date: 2014-04-15    
-- Description: 手机客户端获取每月进步数据  
-- Memo:      
*/     
CREATE Procedure [dbo].[and_hb_monthgrow_GetList]  
@cid Int,  
@term Varchar(50),  
@pos Int  
as  
  
Select a.gbid, c.diaryid, e.name username, e.userid, Case When c.diaryid > 0 Then 1 Else 0 End status  
  From NGBApp.dbo.growthbook a Left Join NGBApp.dbo.Diary_page_month_sec c On a.gbid = c.gbid and c.title = @pos,   
       BasicData.dbo.user_class_all b, BasicData.dbo.[user] e  
  Where a.userid = b.userid and b.cid = @cid and a.term = @term and b.userid = e.userid and a.term=b.term
  
GO
