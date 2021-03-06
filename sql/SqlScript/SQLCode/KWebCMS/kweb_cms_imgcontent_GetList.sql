USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_imgcontent_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[kweb_cms_imgcontent_GetList]
@categorycode nvarchar(20),
@siteid int,
@page int,
@size int
AS
BEGIN
    IF(@page>1)
    BEGIN
        DECLARE @count int
        DECLARE @ignore int
        
        SET @count=@page*@size
        SET @ignore=@count-@size
        
        DECLARE @temptable TABLE
        (
            row int identity(1,1) primary key,
            temp_contentid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT contentid FROM cms_imgcontent
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) and deletetag = 1
		ORDER BY [orderno] DESC
        
        SET ROWCOUNT @size
        SELECT [contentid],[categoryid],[content],[title],[titlecolor],[author],[createdatetime],[viewcount],[orderno],[status],[isindexshow],[imgtitleurl],[targeturl]
        FROM cms_imgcontent,@temptable
        WHERE contentid=temp_contentid AND row>@ignore and deletetag = 1
		ORDER BY [orderno] DESC
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [contentid],[categoryid],[content],[title],[titlecolor],[author],[createdatetime],[viewcount],[orderno],[status],[isindexshow],[imgtitleurl],[targeturl]
        FROM cms_imgcontent
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) and deletetag = 1
		and isindexshow=1
		ORDER BY [orderno] DESC
    END
    ELSE
    BEGIN
        SELECT [contentid],[categoryid],[content],[title],[titlecolor],[author],[createdatetime],[viewcount],[orderno],[status],[isindexshow],[imgtitleurl],[targeturl]
        FROM cms_imgcontent
		WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE categorycode=@categorycode AND siteid=@siteid) and deletetag = 1
		ORDER BY [orderno] DESC
    END
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_imgcontent_GetList', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_imgcontent_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'页码' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_imgcontent_GetList', @level2type=N'PARAMETER',@level2name=N'@page'
GO
