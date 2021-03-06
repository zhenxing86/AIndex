USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_GetCountByDate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-12
-- Description:	GetCountByDate
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_GetCountByDate]
@startdate datetime,
@enddate datetime
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM actionlogs WHERE actiondatetime>=@startdate and actiondatetime<=@enddate
	RETURN @count
END



GO
