USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[blog_posts_Delete]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-21
-- Description:	删除精彩文章
-- =============================================
CREATE PROCEDURE [dbo].[blog_posts_Delete]
@postid int
AS
BEGIN
	
	declare @siteid int
	select @siteid=siteid from blog_posts where postid=@postid
	DELETE blog_posts WHERE postid=@postid

	delete [blog_posts_list] where postid=@postid

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
