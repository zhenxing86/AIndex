USE [NGBApp]
GO
/****** Object:  StoredProcedure [dbo].[GetbbdaInfo]    Script Date: 2014/11/24 23:18:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
-- Author:      xie    
-- Create date: 2014-08-18     
-- Description: 读取宝贝档案信息    
-- Memo:use ngbapp      
exec GetDiary 3065190    
*/   
create proc [dbo].[GetbbdaInfo]  
@gbid int  
as  
begin  
      
 SELECT gbid, d.pagetplid, d.diaryid, CASE WHEN u.usertype = 0 then 0 else 1 end AuthorType, d.CrtDate, pp.ckey, pp.cvalue, pp.ctype        
  FROM diary d         
   inner join page_public pp        
   on pp.diaryid = d.diaryid        
  LEFT JOIN BasicData..[user] u        
   on u.userid = d.Author        
  where d.gbid = @gbid and d.pagetplid=11  
  
end  
GO
