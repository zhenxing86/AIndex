USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalkincontent_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	得到招聘或园长评价文章 Model
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalkincontent_GetModel]
@contentid int
AS
BEGIN
	SELECT p.contentid,contenttype,s.siteid,title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,[name],sitedns,regdatetime,content
	FROM portalkincontent p,cms_content c,site s 
	WHERE p.contentid=c.contentid AND p.fromsiteid=s.siteid AND p.contentid=@contentid and c.deletetag = 1 and p.deletetag = 1
END

GO
