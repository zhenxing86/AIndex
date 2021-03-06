USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_GetList]
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
		INSERT INTO @tmptable(tmptableid) SELECT siteid FROM site WHERE status=1 ORDER BY regdatetime DESC

		SET ROWCOUNT @size
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount] 
		FROM site s join @tmptable on s.siteid=tmptableid 
		WHERE row > @ignore ORDER BY row ASC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount] 
		FROM site WHERE status=1 ORDER BY regdatetime DESC
	END
	ELSE
	BEGIN
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount] 
		FROM site WHERE status=1 ORDER BY regdatetime DESC
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_site_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
