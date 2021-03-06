USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_count]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-7
-- Description:	聚合页面统计数量
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_count]
@userid int,
@account nvarchar(30),
@actionmodul int,
@begindate datetime,
@enddate datetime
AS
DECLARE @count int
    SELECT @count=COUNT(*)
    FROM actionlogs a
      INNER JOIN
            Blog..blog_user b ON a.userid=b.userid
      WHERE 
            account like '%'+@account+'%'
            AND a.userid=CASE @userid WHEN 0 THEN a.userid ELSE @userid END
            AND actionmodul=CASE @actionmodul WHEN -1 THEN actionmodul ELSE @actionmodul END
            AND actiondatetime BETWEEN @begindate AND @enddate
RETURN @count


GO
