USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_GetCountBySiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-22
-- Description:	根据 SiteID 获取操作日志总数
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_GetCountBySiteID]
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM actionlogs_history a 
	WHERE a.kid=@siteid
	RETURN @count
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_GetCountBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
