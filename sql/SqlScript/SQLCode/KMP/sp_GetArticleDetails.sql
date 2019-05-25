USE [KMP]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetArticleDetails]    Script Date: 2014/11/24 23:12:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetArticleDetails]
@KID int,
@RecordID varchar(50)

  AS
Select * from DocList_View Where KID = @KID and RecordID = @RecordID

GO
