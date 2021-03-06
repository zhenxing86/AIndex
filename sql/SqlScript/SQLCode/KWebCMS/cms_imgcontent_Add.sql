USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_imgcontent_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[cms_imgcontent_Add]
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

	declare @neworder int
	select @neworder=max(contentid)+1 from cms_imgcontent	
    INSERT INTO cms_imgcontent([categoryid],[content],[title],[titlecolor],[author],[createdatetime],[viewcount],[orderno],[status],[isIndexShow],[ImgTitleUrl],[TargetUrl])
    VALUES(@categoryid,@content,@title,@titlecolor,@author,GETDATE(),@viewcount,@neworder,@status,@isIndexShow,@ImgTitleUrl,@TargetUrl) 

    IF @@ERROR <> 0
    BEGIN
        RETURN 0
    END
    ELSE
    BEGIN
        RETURN @@IDENTITY
    END
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_imgcontent_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
