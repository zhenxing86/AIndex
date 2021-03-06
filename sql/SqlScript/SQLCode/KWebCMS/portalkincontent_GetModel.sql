USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalkincontent_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	GetModel
-- =============================================
CREATE PROCEDURE [dbo].[portalkincontent_GetModel]
@contentid int
AS
BEGIN
	SELECT p.contentid,p.fromsiteid,p.contenttype,c.categoryid,c.content,c.title,c.titlecolor,c.author,c.createdatetime,c.searchkey,c.searchdescription,c.browsertitle,c.viewcount,c.commentcount,c.orderno,c.commentstatus,c.ispageing 
	FROM portalkincontent p JOIN cms_content c ON p.contentid=c.contentid and c.deletetag = 1
	WHERE p.contentid=@contentid and p.deletetag = 1
END

GO
