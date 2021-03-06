USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[pro_init_TNB_TeachingNoteBook]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[pro_init_TNB_TeachingNoteBook]  
as  
  
delete TNB_TeachingNoteBook  
  
insert into TNB_TeachingNoteBook(  
teachingnotebookid,  
[booktitle],  
 [createdate],  
 [username],  
 [chapterid],  
 [chaptertitle],  
 [kname],  
 [booktype],  
 [exquisite],chaptercontent)  
   
SELECT  t1.teachingnotebookid,t1.booktitle,t1.createdate,t1.username,t3.chapterid  
,t3.chaptertitle,t2.kname,booktype,[exquisite],t3.chaptercontent  
 FROM  [EBook]..TNB_TeachingNoteBook t1  
 inner join [gartenlist] t2 on t1.kid=t2.kid     
 inner join ebook..TNB_Chapter t3 on t1.teachingnotebookid = t3.teachingnotebookid and t3.deletetag = 1
 order by t1.createdate desc  

GO
