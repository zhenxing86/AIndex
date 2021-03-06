USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_revertresult_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[vote_item_revertresult_Add]
@voteitemid int,
@answer ntext='',
@votefromip nvarchar(30)=''
AS
BEGIN
    INSERT INTO vote_item_revertresult([voteitemid],[answer],[votedatetime],[votefromip])
    VALUES(@voteitemid,@answer,GETDATE(),@votefromip) 

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
