USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentcomment_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-11
-- Description:	得到评论实体
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentcomment_GetModel]
@contentcommentid int
AS
BEGIN
	SELECT * FROM cms_contentcomment WHERE contentcommentid=@contentcommentid
END



GO
