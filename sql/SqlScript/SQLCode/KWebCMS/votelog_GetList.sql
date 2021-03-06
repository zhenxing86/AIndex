USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[votelog_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[votelog_GetList]
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
            temp_voteid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT voteid FROM votelog
		ORDER BY createdatetime DESC
        
        SET ROWCOUNT @size
        SELECT [voteid],[siteid],[fromip],[result],[createdatetime]
        FROM votelog,@temptable
        WHERE voteid=temp_voteid AND row>@ignore
		ORDER BY createdatetime DESC    
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [voteid],[siteid],[fromip],[result],[createdatetime]
        FROM votelog
		ORDER BY createdatetime DESC    
    END
    ELSE
    BEGIN
        SELECT [voteid],[siteid],[fromip],[result],[createdatetime]
        FROM votelog
		ORDER BY createdatetime DESC    
    END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'votelog_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
