USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalphoto_GetPhotoCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	PortalPhoto_Photo_GetCount
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalphoto_GetPhotoCount]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(o.photoid) 
	FROM portalphoto o,cms_photo p,cms_category c 
	WHERE o.photoid=p.photoid AND p.categoryid=c.categoryid AND c.categorycode=@categorycode AND o.siteid=@siteid and p.deletetag = 1
	return @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalphoto_GetPhotoCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalphoto_GetPhotoCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
