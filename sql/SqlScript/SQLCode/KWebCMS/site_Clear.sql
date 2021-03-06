USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_Clear]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-13
-- Description:	清空指定SiteID的所有数据
-- =============================================
CREATE PROCEDURE [dbo].[site_Clear]
@siteid int
AS
BEGIN
	BEGIN TRANSACTION
	
	--DELETE site_menu WHERE siteid=@siteid

	--DELETE site_usermenu WHERE siteid=@siteid

	--DELETE site_user WHERE siteid=@siteid

	DELETE site_themelist WHERE siteid=@siteid

	DELETE site_themesetting WHERE siteid=@siteid

	DELETE cms_contentpaging WHERE contentid IN (SELECT contentid FROM cms_content WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid))

	DELETE cms_contentcomment WHERE contentid IN (SELECT contentid FROM cms_content WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid))

	DELETE cms_photocomment WHERE photoid IN (SELECT photoid FROM cms_photo WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid))

	DELETE cms_content WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

	DELETE cms_contentattachs WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

	DELETE cms_photo WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

	DELETE cms_album WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

	--DELETE cms_category WHERE siteid=@siteid

	--DELETE actionlogs

	--DELETE invest_user

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN -1
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
END






GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_Clear', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
