USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[actionlogs_GetListByUserID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-09
-- Description:	根据 userid 获取日志列表
-- =============================================
CREATE PROCEDURE [dbo].[actionlogs_GetListByUserID]
@userid int,
@usertype int,
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
		INSERT INTO @tmptable(tmptableid) SELECT id FROM actionlogs WHERE userid=@userid and usertype=@usertype ORDER BY actiondatetime DESC

		SET ROWCOUNT @size
		SELECT c.* FROM actionlogs c join @tmptable on c.id=tmptableid WHERE row > @ignore ORDER BY actiondatetime DESC
	END
	ELSE
	BEGIN
		SET ROWCOUNT @size
		SELECT * FROM actionlogs WHERE userid=@userid and usertype=@usertype ORDER BY actiondatetime DESC
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'actionlogs_GetListByUserID', @level2type=N'PARAMETER',@level2name=N'@page'
GO
