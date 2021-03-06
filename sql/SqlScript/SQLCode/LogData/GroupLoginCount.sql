USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[GroupLoginCount]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-28
-- Description:	聚合页面登录统计数量
-- =============================================
CREATE PROCEDURE [dbo].[GroupLoginCount]
@startdate datetime,
@enddate datetime,
@usertype int
AS
DECLARE @result int
SET @result=
ISNULL((SELECT count(*) from kmp..T_Users WHERE
EXISTS (
select actionuserid from ebook_logs
where kmp..T_Users.ID=ebook_logs.actionuserid and
actionmodul=13 and
UserType=CASE @usertype WHEN -2 THEN UserType ELSE @usertype END
and actiondatetime between @startdate and @enddate)),0)
RETURN @result

GO
