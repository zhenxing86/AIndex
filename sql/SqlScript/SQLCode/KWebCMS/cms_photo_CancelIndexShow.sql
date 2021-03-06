USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_CancelIndexShow]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
-- Author:      Master谭
-- Create date: 2013-07-20
-- Description:	图片首页显示
-- Memo:
*/
CREATE PROCEDURE [dbo].[cms_photo_CancelIndexShow]
	@categoryid int,
	@siteid int
AS
BEGIN
	UPDATE cms_photo 
		SET indexshow = 0 
		WHERE categoryid = @categoryid 
			and siteid = @siteid 
			and indexshow = 1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_CancelIndexShow', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_photo_CancelIndexShow', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
