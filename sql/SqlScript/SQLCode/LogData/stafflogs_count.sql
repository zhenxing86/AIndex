USE [LogData]
GO
/****** Object:  StoredProcedure [dbo].[stafflogs_count]    Script Date: 2014/11/24 23:14:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		gaolao
-- Create date: 2011-3-10
-- Description:	我的教案登录数量
-- =============================================
CREATE PROCEDURE [dbo].[stafflogs_count]
@startdate datetime,
@enddate datetime
AS
DECLARE @result int
SET @result=
ISNULL((SELECT count(*) from kmp..T_Staffer WHERE
EXISTS (
select actionuserid from ebook_logs 
where kmp..T_Staffer.UserID=ebook_logs.actionuserid and actionmodul=1 and actiondatetime between @startdate and @enddate)),0)
RETURN @result

GO
