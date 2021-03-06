USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_defaultMediaPlayer_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-11
-- Description:	getDefaultMediaPlaper
-- =============================================
CREATE PROCEDURE [dbo].[kweb_defaultMediaPlayer_GetModel]
@siteid int
AS
BEGIN	
	SELECT contentattachsid,categoryid,contentid,title,filepath,[filename],filesize,viewcount,createdatetime,attachurl,
	'categoryTitle'=(SELECT title FROM cms_category WHERE categoryid=c.categoryid) 
	FROM cms_contentattachs c 
	WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=58 AND categorycode='JCSP') and c.deletetag = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_defaultMediaPlayer_GetModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
