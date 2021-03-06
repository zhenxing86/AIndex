USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_GetCountBySiteIDAndDate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	根据日期搜索指定站点的日志总数
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_GetCountBySiteIDAndDate]
@siteid int,
@startdate datetime,
@enddate datetime
AS
BEGIN	
	DECLARE @count int
	SELECT @count=count(*) FROM actionlogs_history a
	WHERE a.kid=@siteid AND actiondatetime>=@startdate and actiondatetime<=@enddate
	RETURN @count
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_GetCountBySiteIDAndDate', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
