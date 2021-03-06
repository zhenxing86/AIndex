USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetCountByRegDate_tmp]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
create PROCEDURE [dbo].[actionlogs_Stat_GetCountByRegDate_tmp]
@startdatetime datetime,
@enddatetime datetime
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(DISTINCT s.siteid) FROM site s,actionlogs a,site_user u 
	WHERE a.userid=u.userid AND s.siteid=u.siteid AND regdatetime>=@startdatetime AND regdatetime<=@enddatetime
	RETURN @count
END
GO
