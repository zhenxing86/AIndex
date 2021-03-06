USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	分页获取站点
-- =============================================
CREATE PROCEDURE [dbo].[site_GetListByPage]
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
		INSERT INTO @tmptable(tmptableid) SELECT siteid FROM site ORDER BY siteid DESC

		SET ROWCOUNT @size
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount],[status] FROM site s join @tmptable on s.siteid=tmptableid WHERE row > @ignore ORDER BY siteid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount],[status] FROM site ORDER BY siteid DESC
	END
	ELSE
	BEGIN
		SELECT [siteid],[name],[description],[address],[sitedns],[provice],[city],[regdatetime],[contractname],[QQ],[phone],[accesscount],[status] FROM site ORDER BY siteid DESC
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
