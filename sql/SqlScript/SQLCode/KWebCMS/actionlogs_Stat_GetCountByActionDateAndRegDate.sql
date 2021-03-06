USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_Stat_GetCountByActionDateAndRegDate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-08-05
-- Description:	[actionlogs_Stat_GetCountByActionDateAndRegDate] '',''
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_Stat_GetCountByActionDateAndRegDate]
@startactiondatetime datetime,
@endactiondatetime datetime,
@startregdatetime datetime,
@endregdatetime datetime
AS
BEGIN
	DECLARE @count int
--	SELECT @count=count(DISTINCT s.siteid) FROM site s,actionlogs a,site_user u 
--	WHERE a.userid=u.userid AND s.siteid=u.siteid 
--	AND regdatetime>=@startregdatetime AND regdatetime<=@endregdatetime
--	AND actiondatetime>=@startactiondatetime AND actiondatetime<=@endactiondatetime
--
--declare @startregdatetime  datetime
--declare @endregdatetime  datetime
--declare @startactiondatetime  datetime
--declare @endactiondatetime  datetime
--set @startregdatetime = '2012-10-01'
--set @endregdatetime = '2012-10-20'
--set @startactiondatetime = '2012-10-01'
--set @endactiondatetime = '2012-10-20'

select @count=count(DISTINCT a.kid)  from actionlogs_history a 
left join site s on a.kid=s.siteid
where regdatetime between @startregdatetime and @endregdatetime
and actiondatetime between @startactiondatetime and @endactiondatetime
	RETURN @count
END



GO
