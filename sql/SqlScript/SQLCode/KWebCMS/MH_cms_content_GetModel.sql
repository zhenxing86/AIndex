USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_cms_content_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[MH_cms_content_GetModel]
@contentid int
AS
BEGIN
	SELECT [content],t1.title,titlecolor,author,t1.createdatetime,ispageing,'categorytitle'=t2.title 
	FROM cms_content t1 LEFT JOIN cms_category t2 ON t1.categoryid=t2.categoryid
 WHERE contentid=@contentid and t1.deletetag = 1
END

GO
