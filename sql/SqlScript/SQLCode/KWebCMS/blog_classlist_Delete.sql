USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_classlist_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	删除班级到网站首页
-- =============================================
CREATE PROCEDURE [dbo].[blog_classlist_Delete]
@classid int
AS
BEGIN
	DELETE blog_classlist WHERE classid=@classid

	declare @siteid int
	select @siteid=kid from basicdata..class where cid=@classid

	exec [kweb_site_RefreshIndexPage] @siteid

	IF @@ERROR <> 0	
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_classlist_Delete', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
