USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[childlogs_count]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-10
-- Description:	我的成长档案登录数量
-- =============================================
CREATE PROCEDURE [dbo].[childlogs_count]
@startdate datetime,
@enddate datetime
AS
DECLARE @result int
SET @result=
ISNULL((SELECT count(*) from kmp..T_Child WHERE
EXISTS (
select actionuserid from ebook_logs 
where kmp..T_Child.UserID=ebook_logs.actionuserid and
actionmodul=1 and actiondatetime between @startdate and @enddate)),0)
RETURN @result

GO
