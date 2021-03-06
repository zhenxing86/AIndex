USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_imgcontent_Update]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[cms_imgcontent_Update]
@contentid int,
@categoryid int,
@content ntext='',
@title nvarchar(50)='',
@titlecolor nvarchar(50)='',
@author nvarchar(20)='',
@viewcount int,
@orderno int,
@status bit,
@isIndexShow bit,
@ImgTitleUrl nvarchar(300)='',
@TargetUrl nvarchar(100)=''
AS
BEGIN
    UPDATE cms_imgcontent
    SET categoryid=@categoryid,content=@content,title=@title,
titlecolor=@titlecolor,author=@author,viewcount=@viewcount,
status=@status,isIndexShow=@isIndexShow,ImgTitleUrl=@ImgTitleUrl,TargetUrl=@TargetUrl
    WHERE contentid=@contentid

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN 1
    END
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_imgcontent_Update', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
