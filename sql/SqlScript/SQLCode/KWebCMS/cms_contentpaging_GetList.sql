USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentpaging_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-02
-- Description:	GetList
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentpaging_GetList]
@contentid int
AS
BEGIN
	SELECT pagingid,contentid,[content],createdate FROM cms_contentpaging WHERE contentid=@contentid
END



GO
