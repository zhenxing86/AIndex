USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalphoto_GetRandomPhotoListByPage]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-27
-- Description:	PortalPhoto_Photo_GetRandomList
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalphoto_GetRandomPhotoListByPage]
@categorycode nvarchar(10),
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
		SELECT o.photoid FROM portalphoto o,cms_photo p,cms_category c 
		WHERE o.photoid=p.photoid AND p.categoryid=c.categoryid AND c.categorycode=@categorycode and p.deletetag = 1
		ORDER BY o.photoid DESC

		SET ROWCOUNT @size
		SELECT p.photoid,p.title,p.filename,p.filepath,p.createdatetime 
		FROM portalphoto o,cms_photo p,cms_category c,@tmptable 
		WHERE row>@ignore AND o.photoid=tmptableid AND o.photoid=p.photoid AND p.categoryid=c.categoryid 
      AND c.categorycode=@categorycode and p.deletetag = 1
		ORDER BY o.photoid DESC
	END
	ELSE IF(@page=1)
	BEGIN
		SET ROWCOUNT @size
		SELECT p.photoid,p.title,p.filename,p.filepath,p.createdatetime 
		FROM portalphoto o,cms_photo p,cms_category c 
		WHERE o.photoid=p.photoid AND p.categoryid=c.categoryid AND c.categorycode=@categorycode and p.deletetag = 1
		ORDER BY o.photoid DESC
	END
	ELSE IF(@page=0)
	BEGIN
		SELECT p.photoid,p.title,p.filename,p.filepath,p.createdatetime 
		FROM portalphoto o,cms_photo p,cms_category c 
		WHERE o.photoid=p.photoid AND p.categoryid=c.categoryid AND c.categorycode=@categorycode and p.deletetag = 1
		ORDER BY o.photoid DESC
	END	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalphoto_GetRandomPhotoListByPage', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalphoto_GetRandomPhotoListByPage', @level2type=N'PARAMETER',@level2name=N'@page'
GO
