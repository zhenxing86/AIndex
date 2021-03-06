USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[doc_Document_Delete]    Script Date: 2014/11/24 23:12:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE     PROCEDURE [dbo].[doc_Document_Delete]
(
	@RecordID varchar(16)
) 
AS

SET Transaction Isolation Level Read UNCOMMITTED


Delete FROM doc_Document_InCategories where RecordID = @RecordID
Delete FROM doc_Document where RecordID = @RecordID
Delete FROM doc_Document_File where RecordID = @RecordID
Delete FROM doc_Document_Attach where RecordID = @RecordID

exec doc_Documents_UpdateDocumentsInCategories @RecordID = @RecordID
GO
