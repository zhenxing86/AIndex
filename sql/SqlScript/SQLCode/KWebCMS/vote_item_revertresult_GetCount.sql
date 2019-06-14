USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_revertresult_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vote_item_revertresult_GetCount]
@voteitemid int
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM vote_item_revertresult WHERE voteitemid=@voteitemid
    RETURN @count
END



GO
