USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_DeleteALL]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-27
-- Description:	彻底删除网站所有信息
--update site SET status=0 WHERE siteid in (select id from kmp..t_kindergarten where city=240 and id not in (7079,8659,8661,8662,8664,8671,8673))
--exec site_deleteall 
-- =============================================
CREATE PROCEDURE [dbo].[site_DeleteALL]
	@siteid int
AS
BEGIN
	SET NOCOUNT ON
	Begin tran   
	BEGIN TRY  
		DELETE actionlogs WHERE userid IN (SELECT userid FROM site_user WHERE siteid=@siteid)
		DELETE cms_album WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

		DELETE cms_contentcomment WHERE contentid IN (SELECT contentid FROM cms_content WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid))
		DELETE cms_contentpaging WHERE contentid IN (SELECT contentid FROM cms_content WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid))
		DELETE cms_content WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

		DELETE cms_contentattachs WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)
		DELETE cms_imgcontent WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

		DELETE cms_photocomment WHERE photoid IN (SELECT photoid FROM cms_photo WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid))
		DELETE cms_photo WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=@siteid)

		DELETE defaultpage WHERE siteid=@siteid
		DELETE kin_friendhref WHERE siteid=@siteid
		DELETE permissionsetting WHERE siteid=@siteid
		DELETE portalarticle WHERE siteid=@siteid
		DELETE portalattach WHERE siteid=@siteid
		DELETE portalcontent WHERE siteid=@siteid
		DELETE portalphoto WHERE siteid=@siteid
		DELETE site_accessdetail WHERE siteid=@siteid
		DELETE site_copyright WHERE siteid=@siteid
		DELETE site_domain WHERE siteid=@siteid
		DELETE site_menu WHERE siteid=@siteid
		DELETE site_themesetting WHERE siteid=@siteid

		DELETE site_themeicon WHERE themeid IN (SELECT themeid FROM site_themelist WHERE siteid=@siteid)
		DELETE site_themestyle WHERE themeid IN (SELECT themeid FROM site_themelist WHERE siteid=@siteid)
		DELETE site_themelist WHERE siteid=@siteid

		DELETE site_usermenu WHERE siteid=@siteid
		DELETE votelog WHERE siteid=@siteid

		delete basicdata..[user] where kid = @siteid and kid <> 0
		delete basicdata..class where kid=@siteid
		delete basicdata..department where kid=@siteid
		delete basicdata..kindergarten where kid=@siteid
		
		DELETE cms_category WHERE siteid=@siteid
		DELETE site_user WHERE siteid=@siteid
		DELETE site WHERE siteid=@siteid

		Commit tran                              
	End Try      
	Begin Catch      
		Rollback tran   
		Return  -1      
	end Catch  
	Return 1
   
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_DeleteALL', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
