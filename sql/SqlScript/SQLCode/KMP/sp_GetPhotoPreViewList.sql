USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPhotoPreViewList]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[sp_GetPhotoPreViewList]
@CategoryID int,
@ClassID int,
@KID int
 AS
if (@ClassID=0)
	select dv.Subject, dv.RecordID, dv.Description, dv.author, dv.classID, dv.kid, dv.categoryID,dv.filecount, ddp.* from doclist_view dv, doc_document_photo ddp  
	where dv.categoryid = @CategoryID and dv.kid=@KID and dv.RecordID=ddp.RecordID and ddp.IsCover=1 order by ddp.datecreated desc
else
select dv.Subject, dv.RecordID, dv.Description, dv.author, dv.classID, dv.kid, dv.categoryID,dv.filecount, ddp.* from doclist_view dv, doc_document_photo ddp  
	where dv.categoryid = @CategoryID and dv.kid=@KID and dv.ClassID=@ClassID and dv.RecordID=ddp.RecordID and ddp.IsCover=1 order by ddp.datecreated desc
GO
