USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPhotoView]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetPhotoView]
@KID int,
@PhotoID varchar(50)

  AS
Select * from doc_document_photo Where PhotoID = @PhotoID
GO
