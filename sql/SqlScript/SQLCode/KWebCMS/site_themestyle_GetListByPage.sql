USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themestyle_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-15
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[site_themestyle_GetListByPage]
@themeid int,
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
		SELECT styleid FROM site_themestyle
		WHERE themeid=@themeid ORDER BY styleid DESC

		SET ROWCOUNT @size
		SELECT styleid,themeid,title,thumbpath,webstyle,createdatetime
		FROM site_themestyle join @tmptable on styleid=tmptableid WHERE row > @ignore ORDER BY styleid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT styleid,themeid,title,thumbpath,webstyle,createdatetime
		FROM site_themestyle 
		WHERE themeid=@themeid
		ORDER BY styleid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT styleid,themeid,title,thumbpath,webstyle,createdatetime
		FROM site_themestyle 
		WHERE themeid=@themeid
		ORDER BY styleid DESC	
	END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themestyle_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
