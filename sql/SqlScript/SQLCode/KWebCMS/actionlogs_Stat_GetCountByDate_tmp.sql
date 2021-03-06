USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetCountByDate_tmp]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-08-05
-- Description:	GetLogCount
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Stat_GetCountByDate_tmp]
@startdatetime datetime,
@enddatetime datetime
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(DISTINCT s.siteid) FROM site s,actionlogs a,site_user u 
	WHERE a.userid=u.userid AND s.siteid=u.siteid AND actiondatetime>=@startdatetime AND actiondatetime<=@enddatetime
	RETURN @count
END


GO
