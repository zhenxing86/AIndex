USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_imgcontent_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kweb_cms_imgcontent_GetCount]
@categorycode nvarchar(20),
@siteid int
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM cms_imgcontent 
    WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) and deletetag = 1
    RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_imgcontent_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_imgcontent_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
