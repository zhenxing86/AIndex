USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_subject_GetListByKWeb]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[vote_subject_GetListByKWeb]
@siteid int,
@page int,
@size int
AS
BEGIN
    IF(@page>1)
    BEGIN
        DECLARE @count int
        DECLARE @ignore int
        
        SET @count=@page*@size
        SET @ignore=@count-@size
        
        DECLARE @temptable TABLE
        (
            row int identity(1,1) primary key,
            temp_votesubjectid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT votesubjectid FROM vote_subject 
		WHERE siteid=@siteid AND status=1
        
        SET ROWCOUNT @size
        SELECT [votesubjectid],[siteid],[title],[description],[votetype],[status],[createdatetime]
        FROM vote_subject,@temptable
        WHERE votesubjectid=temp_votesubjectid AND row>@ignore
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [votesubjectid],[siteid],[title],[description],[votetype],[status],[createdatetime]
        FROM vote_subject
		WHERE siteid=@siteid AND status=1
    END
    ELSE
    BEGIN
        SELECT [votesubjectid],[siteid],[title],[description],[votetype],[status],[createdatetime]
        FROM vote_subject
		WHERE siteid=@siteid AND status=1
    END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'vote_subject_GetListByKWeb', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'vote_subject_GetListByKWeb', @level2type=N'PARAMETER',@level2name=N'@page'
GO
