USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalattach_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[portalattach_GetList]
@categorycode nvarchar(20),
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
		INSERT INTO @tmptable(tmptableid) SELECT portalattachid FROM portalattach ORDER BY portalattachid DESC

		SET ROWCOUNT @size
		SELECT p.attachid,p.siteid,s.name,s.sitedns,c.title,c.filepath,c.filename,c.attachurl,c.createdatetime
		FROM site s,cms_contentattachs c,portalattach p,@tmptable 
		WHERE row > @ignore AND portalattachid=tmptableid AND c.contentattachsid=p.attachid AND s.siteid=p.siteid and c.deletetag = 1
		ORDER BY portalattachid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT p.attachid,p.siteid,s.name,s.sitedns,c.title,c.filepath,c.filename,c.attachurl,c.createdatetime
		FROM site s,cms_contentattachs c,portalattach p 
		WHERE c.contentattachsid=p.attachid AND s.siteid=p.siteid and c.deletetag = 1
		ORDER BY portalattachid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT p.attachid,p.siteid,s.name,s.sitedns,c.title,c.filepath,c.filename,c.attachurl,c.createdatetime
		FROM site s,cms_contentattachs c,portalattach p 
		WHERE c.contentattachsid=p.attachid AND s.siteid=p.siteid and c.deletetag = 1
		ORDER BY portalattachid DESC
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalattach_GetList', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalattach_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
