USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_imgcontent_GetModelByIndexShow]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kweb_cms_imgcontent_GetModelByIndexShow]
@categorycode nvarchar(20),
@siteid int
AS
BEGIN
    SELECT [contentid],[categoryid],[content],[title],[titlecolor],[author],[createdatetime],[viewcount],[orderno],[status],[isindexshow],[imgtitleurl]
    FROM cms_imgcontent
    WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) AND isIndexSHow=1 and deletetag = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_imgcontent_GetModelByIndexShow', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_imgcontent_GetModelByIndexShow', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
