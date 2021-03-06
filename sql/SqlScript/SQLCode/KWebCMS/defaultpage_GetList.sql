USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[defaultpage_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-21
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[defaultpage_GetList]
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
			--定义临时表
			row int IDENTITY (1, 1),
			tmptableid bigint
		)
		
		SET ROWCOUNT @prep
		INSERT INTO @tmptable(tmptableid) SELECT defaultpageid FROM defaultpage
		WHERE siteid=@siteid ORDER BY defaultpageid DESC

		SET ROWCOUNT @size
		SELECT defaultpageid,siteid,defaultpage,startdatetime,enddatetime
		FROM defaultpage d join @tmptable on d.defaultpage=tmptableid WHERE row > @ignore ORDER BY defaultpageid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT defaultpageid,siteid,defaultpage,startdatetime,enddatetime
		FROM defaultpage WHERE siteid=@siteid ORDER BY defaultpageid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT defaultpageid,siteid,defaultpage,startdatetime,enddatetime
		FROM defaultpage WHERE siteid=@siteid ORDER BY defaultpageid DESC
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'defaultpage_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'defaultpage_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
