USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalkincontent_GetListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[portalkincontent_GetListByPage]
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
		INSERT INTO @tmptable(tmptableid) SELECT contentid FROM portalkincontent Where deletetag = 1
		ORDER BY contentid DESC 

		SET ROWCOUNT @size
		SELECT p.contentid,p.fromsiteid,p.contenttype,title,createdatetime,ispageing
		FROM portalkincontent p,cms_content c,@tmptable 
		WHERE p.contentid=tmptableid AND p.contentid=c.contentid AND row > @ignore and c.deletetag = 1 and p.deletetag = 1
		ORDER BY p.contentid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT p.contentid,p.fromsiteid,p.contenttype,title,createdatetime,ispageing
		FROM portalkincontent p,cms_content c WHERE p.contentid=c.contentid and c.deletetag = 1 and p.deletetag = 1
		ORDER BY p.contentid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT p.contentid,p.fromsiteid,p.contenttype,title,createdatetime,ispageing
		FROM portalkincontent p,cms_content c WHERE p.contentid=c.contentid and c.deletetag = 1 and p.deletetag = 1
		ORDER BY p.contentid DESC
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalkincontent_GetListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
