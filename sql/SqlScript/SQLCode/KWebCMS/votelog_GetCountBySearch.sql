USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[votelog_GetCountBySearch]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[votelog_GetCountBySearch]
@startDate datetime,
@endDate datetime
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM votelog WHERE createdatetime BETWEEN @startDate AND @endDate
    RETURN @count
END


GO
