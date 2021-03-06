USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetVideoPreViewList]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[sp_GetVideoPreViewList]
@CategoryID int,
@ClassID int,
@KID int
 AS
	select dv.Subject, dv.RecordID, dv.Description, dv.author, dv.classID, dv.kid, dv.categoryID, dda.* from doclist_view dv, doc_document_attach dda
	where dda.recordid = dv.recordid and dv.categoryid = @CategoryID and dv.kid=@KID and dv.ClassID=@ClassID order by dda.datecreated desc
	

GO
