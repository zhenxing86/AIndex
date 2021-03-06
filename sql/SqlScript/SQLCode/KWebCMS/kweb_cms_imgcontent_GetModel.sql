USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_imgcontent_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kweb_cms_imgcontent_GetModel]
@contentid int
AS
BEGIN
    SELECT [contentid],[categoryid],[content],[title],[titlecolor],[author],[createdatetime],[viewcount],[orderno],[status],[isindexshow],[imgtitleurl]
    FROM cms_imgcontent
    WHERE contentid=@contentid and deletetag = 1
END

GO
