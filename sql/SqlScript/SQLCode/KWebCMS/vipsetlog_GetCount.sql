USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[vipsetlog_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[vipsetlog_GetCount]
@startactiondatetime datetime,
@endactiondatetime datetime,
@status int
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM vipsetlog
	WHERE actiondatetime BETWEEN @startactiondatetime AND @endactiondatetime
    AND dredgeStatus=CASE @status WHEN 2 THEN dredgeStatus ELSE @status END
    RETURN @count
END

GO
