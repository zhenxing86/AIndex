USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[vote_item_GetList]
@votesubjectid int,
@page int,
@size int
AS
BEGIN
set @size=30
    IF(@page>1)
    BEGIN
        DECLARE @count int
        DECLARE @ignore int
        
        SET @count=@page*@size
        SET @ignore=@count-@size
        
        DECLARE @temptable TABLE
        (
            row int identity(1,1) primary key,
            temp_voteitemid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT voteitemid FROM vote_item
		WHERE votesubjectid=@votesubjectid
        
        SET ROWCOUNT @size
        SELECT [voteitemid],[votesubjectid],[title]
        FROM vote_item,@temptable
        WHERE voteitemid=temp_voteitemid AND row>@ignore
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [voteitemid],[votesubjectid],[title]
        FROM vote_item
		WHERE votesubjectid=@votesubjectid
    END
    ELSE
    BEGIN
        SELECT [voteitemid],[votesubjectid],[title]
        FROM vote_item
		WHERE votesubjectid=@votesubjectid
    END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'vote_item_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
