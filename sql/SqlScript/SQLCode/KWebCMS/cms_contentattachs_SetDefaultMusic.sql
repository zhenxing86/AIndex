USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_SetDefaultMusic]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-04-18
-- Description:	设置默认背影音乐
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_SetDefaultMusic]
@contentattachsid int,
@categoryid int,
@siteid int
AS
BEGIN
  
	BEGIN TRANSACTION
	
	UPDATE cms_contentattachs SET isdefault=0 WHERE categoryid=@categoryid and siteid=@siteid

	UPDATE cms_contentattachs SET isdefault=1 WHERE contentattachsid=@contentattachsid
   
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
		RETURN 1
	END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_SetDefaultMusic', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentattachs_SetDefaultMusic', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
