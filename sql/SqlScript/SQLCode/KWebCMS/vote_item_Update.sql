USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vote_item_Update]
@voteitemid int,
@votesubjectid int,
@title nvarchar(30)=''
AS
BEGIN
    UPDATE vote_item
    SET votesubjectid=@votesubjectid,title=@title
    WHERE voteitemid=@voteitemid

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1
    END
END



GO
