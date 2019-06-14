USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateDocumentPhotoCount]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_UpdateDocumentPhotoCount]
@RecordID varchar(50)
 AS
declare @count int
select @count = count(photoID) from doc_document_photo where RecordID=@RecordID
update doc_document set filecount = @count where RecordID=@RecordID
GO
