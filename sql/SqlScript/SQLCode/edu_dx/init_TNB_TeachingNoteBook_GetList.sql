USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_TNB_TeachingNoteBook_GetList]    Script Date: 08/10/2013 10:23:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[init_TNB_TeachingNoteBook_GetList]
 AS 
	SELECT 
	       [teachingnotebookid]    ,[booktitle]    ,[createdate]    ,[username]    ,[chapterid]    ,[chaptertitle]    ,[kname]    ,[booktype]    ,[exquisite],chaptercontent  	 FROM [TNB_TeachingNoteBook]
GO
