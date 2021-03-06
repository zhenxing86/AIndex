USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_GetListBySiteID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-22
-- Description:	根据 SiteID 获取日志列表
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_GetListBySiteID]
@siteid int,
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
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) 
		SELECT id FROM actionlogs_history a
		WHERE a.kid=@siteid 
		ORDER BY id DESC

		SET ROWCOUNT @size
		SELECT c.* FROM actionlogs_history c join @tmptable on c.id=tmptableid WHERE row > @ignore ORDER BY id DESC
	END
	ELSE IF (@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT a.* FROM actionlogs_history a
		WHERE a.kid=@siteid
		ORDER BY a.id DESC
	END
	ELSE
	BEGIN
		SELECT a.* FROM actionlogs_history a
		WHERE a.kid=@siteid
		ORDER BY a.id DESC
	END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_GetListBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_GetListBySiteID', @level2type=N'PARAMETER',@level2name=N'@page'
GO
