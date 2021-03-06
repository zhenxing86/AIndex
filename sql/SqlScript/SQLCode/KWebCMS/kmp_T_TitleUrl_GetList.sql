USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kmp_T_TitleUrl_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[kmp_T_TitleUrl_GetList]
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
            temp_id int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT id FROM zgyey_om..T_TitleUrl
		WHERE [type]=3
		ORDER BY createdate DESC
        
        SET ROWCOUNT @size
        SELECT [id],[kid],[photourl],[url],[title],[type],[orderno],[createdate],[color]
        FROM zgyey_om..T_TitleUrl,@temptable
        WHERE id=temp_id AND row>@ignore
		ORDER BY createdate DESC
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [id],[kid],[photourl],[url],[title],[type],[orderno],[createdate],[color]
        FROM zgyey_om..T_TitleUrl
		WHERE [type]=3
		ORDER BY createdate DESC
    END
    ELSE
    BEGIN
        SELECT [id],[kid],[photourl],[url],[title],[type],[orderno],[createdate],[color]
        FROM zgyey_om..T_TitleUrl
		WHERE [type]=3
		ORDER BY createdate DESC
    END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kmp_T_TitleUrl_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
