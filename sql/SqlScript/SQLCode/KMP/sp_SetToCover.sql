USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_SetToCover]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[sp_SetToCover]
@PhotoID int,
@RecordID varchar(50)
 AS 
	BEGIN TRAN

	UPDATE doc_document_photo set iscover = 0 where RecordID=@RecordID
	update doc_document_photo set iscover = 1 where PhotoID = @PhotoID	
	
	COMMIT TRAN
GO
