USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_classlist_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-22
-- Description:	添加班级到网站首页
-- =============================================
CREATE PROCEDURE [dbo].[blog_classlist_Add]
@siteid int,
@classid int
AS
BEGIN
	IF EXISTS(SELECT * FROM blog_classlist WHERE siteid=@siteid AND classid=@classid)
	BEGIN
		RETURN 2
	END
	ELSE
	BEGIN
		INSERT INTO blog_classlist(siteid,classid) VALUES(@siteid,@classid)
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
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_classlist_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'班级ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'blog_classlist_Add', @level2type=N'PARAMETER',@level2name=N'@classid'
GO
