USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vote_item_GetModel]
@voteitemid int
AS
BEGIN
    SELECT [voteitemid],[votesubjectid],[title]
    FROM vote_item
    WHERE voteitemid=@voteitemid
END



GO
