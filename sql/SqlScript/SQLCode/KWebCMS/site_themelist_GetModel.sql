USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themelist_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-014
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[site_themelist_GetModel]
@themeid int
AS
BEGIN
	SELECT themeid,siteid,title,thumbpath,status,createdatetime,iscustomer,previewUrl,theme_category_id
	FROM site_themelist
	WHERE themeid=@themeid
END

GO
