USE [EBook]
GO
/****** Object:  StoredProcedure [dbo].[getTNB_Books]    Script Date: 2014/11/24 23:03:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getTNB_Books]
@userid int	
AS
   select t.term,t.teachingnotebookid,t.booktype from EBook..TNB_TeachingNoteBook t   where t.userid = @userid order by t.createdate desc
   

   
GO
