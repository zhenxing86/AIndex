USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetLoginCountByDate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-09-18
-- Description:	用户登录日志
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Stat_GetLoginCountByDate]
@startdatetime datetime,
@enddatetime datetime
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(DISTINCT userid) FROM actionlogs 
	WHERE  actionmodul=-1 AND userid>0 AND actiondatetime BETWEEN @startdatetime AND @enddatetime
	RETURN @count
END


GO
