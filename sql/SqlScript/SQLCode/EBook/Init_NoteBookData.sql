USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[Init_NoteBookData]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Init_NoteBookData]  
   
 AS    
  
  
Update ebook..tnb_chapter set deletetag = 0 where teachingnotebookid=46225  
insert into ebook..tnb_chapter(teachingnotebookid,chaptertitle,subject,grade,createdate,chaptercontent,ordernum,textpagecount,tlfcontent,exquisite)  
select top 20 46225, chaptertitle,subject,grade,'2014-02-27',chaptercontent,ordernum,textpagecount,tlfcontent,exquisite from ebook..tnb_chapter where teachingnotebookid=12145  
  
Update ebook..tnb_chapter set deletetag = 0 where teachingnotebookid=48588  
insert into ebook..tnb_chapter(teachingnotebookid,chaptertitle,subject,grade,createdate,chaptercontent,ordernum,textpagecount,tlfcontent,exquisite)  
select 48588, chaptertitle,subject,grade,'2014-02-27',chaptercontent,ordernum,textpagecount,tlfcontent,exquisite from ebook..tnb_chapter where teachingnotebookid=13921  
  
  
Update ebook..tnb_chapter set deletetag = 0 where teachingnotebookid=48589  
insert into ebook..tnb_chapter(teachingnotebookid,chaptertitle,subject,grade,createdate,chaptercontent,ordernum,textpagecount,tlfcontent,exquisite)  
select 48589, chaptertitle,subject,grade,'2014-02-27',chaptercontent,ordernum,textpagecount,tlfcontent,exquisite from ebook..tnb_chapter where teachingnotebookid=13922  
  

Update ebook..tnb_chapter set deletetag = 0 where teachingnotebookid=46226  
insert into ebook..tnb_chapter(teachingnotebookid,chaptertitle,subject,grade,createdate,chaptercontent,ordernum,textpagecount,tlfcontent,exquisite)  
select 46226, chaptertitle,subject,grade,'2014-02-27',chaptercontent,ordernum,textpagecount,tlfcontent,exquisite from ebook..tnb_chapter where teachingnotebookid=13927  

GO
