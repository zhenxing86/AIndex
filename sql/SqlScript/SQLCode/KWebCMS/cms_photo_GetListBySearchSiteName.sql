USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_GetListBySearchSiteName]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	根据网站名称获取图片
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_GetListBySearchSiteName]
@name nvarchar(50),
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
		INSERT INTO @tmptable(tmptableid) SELECT photoid 
		FROM cms_photo c,cms_category cc,site s
		WHERE c.categoryid=cc.categoryid and c.deletetag = 1
			AND cc.siteid=s.siteid 
			AND s.name LIKE '%'+@name+'%'
			AND photoid NOT IN (SELECT photoid FROM portalphoto)
		ORDER BY s.siteid DESC,photoid DESC	

		SET ROWCOUNT @size
		SELECT c.photoid,c.categoryid,c.title,c.createdatetime,c.filename,c.filepath,name,sitedns 
		FROM cms_photo c,cms_category cc,site s,@tmptable
		WHERE row > @ignore AND c.[photoid]=tmptableid and c.deletetag = 1
			AND c.categoryid=cc.categoryid 
			AND cc.siteid=s.siteid 
		ORDER BY s.siteid DESC,photoid DESC	
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT c.photoid,c.categoryid,c.title,c.createdatetime,c.filename,c.filepath,name,sitedns 
		FROM cms_photo c,cms_category cc,site s
		WHERE c.categoryid=cc.categoryid and c.deletetag = 1
			AND cc.siteid=s.siteid 
			AND s.name LIKE '%'+@name+'%'
			AND photoid NOT IN (SELECT photoid FROM portalphoto)
		ORDER BY s.siteid DESC,photoid DESC	
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT c.photoid,c.categoryid,c.title,c.createdatetime,c.filename,c.filepath,name,sitedns 
		FROM cms_photo c,cms_category cc,site s
		WHERE c.categoryid=cc.categoryid and c.deletetag = 1
			AND cc.siteid=s.siteid 
			AND s.name LIKE '%'+@name+'%'
			AND photoid NOT IN (SELECT photoid FROM portalphoto)
		ORDER BY s.siteid DESC,photoid DESC	
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_GetListBySearchSiteName', @level2type=N'PARAMETER',@level2name=N'@page'
GO
