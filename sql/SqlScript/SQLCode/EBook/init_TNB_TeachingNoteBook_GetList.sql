USE [edu_dx]
GO
/****** Object:  StoredProcedure [dbo].[init_TNB_TeachingNoteBook_GetList]    Script Date: 2014/11/24 23:04:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[init_TNB_TeachingNoteBook_GetList]
 AS 
	SELECT 
	       [teachingnotebookid]    ,[booktitle]    ,[createdate]    ,[username]    ,[chapterid]    ,[chaptertitle]    ,[kname]    ,[booktype]    ,[exquisite],chaptercontent  	 FROM [TNB_TeachingNoteBook]
	


GO
