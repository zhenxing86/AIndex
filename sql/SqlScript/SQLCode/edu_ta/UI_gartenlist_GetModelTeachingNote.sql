USE [edu_ta]
GO
/****** Object:  StoredProcedure [dbo].[UI_gartenlist_GetModelTeachingNote]    Script Date: 2014/11/24 23:06:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UI_gartenlist_GetModelTeachingNote]  
@chapterid int  
 AS   
 SELECT   
 1, chaptertitle,chaptercontent   
 from ebook..TNB_Chapter   
 where chapterid =@chapterid and deletetag = 1 
  

GO
