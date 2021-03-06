USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_subject_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[vote_subject_Update]
@votesubjectid int,
@siteid int,
@title nvarchar(300)='',
@description nvarchar(100)='',
@votetype int,
@status int
AS
BEGIN
    UPDATE vote_subject
    SET siteid=@siteid,title=@title,description=@description,votetype=@votetype,status=@status
    WHERE votesubjectid=@votesubjectid

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'vote_subject_Update', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
