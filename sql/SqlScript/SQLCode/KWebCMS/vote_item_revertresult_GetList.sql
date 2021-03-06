USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vote_item_revertresult_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-14
-- Description:	客观题统计结果
-- =============================================
CREATE PROCEDURE [dbo].[vote_item_revertresult_GetList]
@voteitemid int,
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
            tempid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT voteitemid FROM vote_item_revertresult WHERE voteitemid=@voteitemid
        
        SET ROWCOUNT @size
        SELECT voteitemid,answer,votedatetime,votefromip
        FROM vote_item_revertresult,@temptable
        WHERE voteitemid=tempid AND row>@ignore
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT voteitemid,answer,votedatetime,votefromip
        FROM vote_item_revertresult
		WHERE voteitemid=@voteitemid
    END
    ELSE
    BEGIN
        SELECT voteitemid,answer,votedatetime,votefromip
        FROM vote_item_revertresult
		WHERE voteitemid=@voteitemid
    END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'vote_item_revertresult_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
