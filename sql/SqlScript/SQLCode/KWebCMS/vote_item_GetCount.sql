USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[vote_item_GetCount]
@votesubjectid int
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM vote_item
	WHERE votesubjectid=@votesubjectid
	set @count=10
    RETURN @count
END




GO
