USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalPhoto_GetAlbumCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	PortalPhoto_Album  GetCount
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalPhoto_GetAlbumCount]
@categorycode nvarchar(10)
AS
BEGIN  
 DECLARE @count int  
 SELECT @count=count(DISTINCT o.siteid) FROM portalphoto o,cms_category c,site s,cms_photo p   
 WHERE o.siteid=s.siteid AND o.photoid=p.photoid AND c.categoryid=p.categoryid AND c.categorycode=@categorycode and p.deletetag = 1
 RETURN @count  
END  

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'MH_portalPhoto_GetAlbumCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
