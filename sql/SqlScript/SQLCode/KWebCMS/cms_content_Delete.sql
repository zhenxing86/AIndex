USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	删除文章内容
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_Delete]
@contentid int
AS
BEGIN
	--BEGIN TRANSACTION

	--declare @siteid int
	--select @siteid=siteid from cms_content where [contentid]=@contentid

	Update cms_content Set Deletetag = 0 WHERE [contentid] = @contentid--删除文章内容
	
	DELETE cms_contentcomment WHERE [contentid] = @contentid--删除文章内容评论

	DELETE cms_contentpaging WHERE [contentid] = @contentid--删除分页中子页文章内容
		
	--exec [kweb_site_RefreshIndexPage] @siteid

	IF @@ERROR <> 0 
	BEGIN 
		--ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		--COMMIT TRANSACTION
	   RETURN(1)
	END
END

GO
