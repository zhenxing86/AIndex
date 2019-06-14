USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[getTNB_Books_ByChapterId]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getTNB_Books_ByChapterId]
@chapterId int
	
AS
select e.chapterid,e.chaptertitle,e.subject,e.grade,e.createdate,e.chaptercontent from EBook..TNB_Chapter e where e.chapterid = @chapterId  and e.deletetag = 1

GO
