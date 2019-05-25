USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentcomment_GetListBycontentcommentID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-07
-- Description:	获取回复的评论
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentcomment_GetListBycontentcommentID]
@contentcommentid int
AS
BEGIN
	SELECT * FROM cms_contentcomment WHERE parentid=@contentcommentid
END



GO
