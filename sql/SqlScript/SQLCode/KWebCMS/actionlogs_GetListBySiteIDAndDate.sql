USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_GetListBySiteIDAndDate]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	根据日期搜索指定站点的日志
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_GetListBySiteIDAndDate]
@siteid int,
@startdate datetime,
@enddate datetime,
@page int,
@size int
AS
BEGIN	
	IF(@page>1)
	BEGIN
		DECLARE @prep int,@ignore int
		
		SET @prep = @size * @page
		SET @ignore=@prep - @size

		DECLARE @tmptable TABLE
		(
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT id FROM actionlogs_history a WHERE a.kid=@siteid AND actiondatetime>=@startdate and actiondatetime<=@enddate ORDER BY actiondatetime DESC

		SET ROWCOUNT @size
		SELECT c.* FROM actionlogs_history c join @tmptable on c.id=tmptableid WHERE row > @ignore ORDER BY actiondatetime DESC
	END
	ELSE IF(@page=1)
	BEGIN 
		SET ROWCOUNT @size
		SELECT * FROM actionlogs_history a WHERE a.kid=@siteid AND actiondatetime>=@startdate and actiondatetime<=@enddate ORDER BY actiondatetime DESC
	END
	ELSE
	BEGIN
		SELECT * FROM actionlogs_history a WHERE a.kid=@siteid AND actiondatetime>=@startdate and actiondatetime<=@enddate ORDER BY actiondatetime DESC
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_GetListBySiteIDAndDate', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_GetListBySiteIDAndDate', @level2type=N'PARAMETER',@level2name=N'@page'
GO
