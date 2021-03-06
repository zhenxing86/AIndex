USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[DataTransfer_cms_Photo_Add]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-05-18
-- Description:	数据转换--Add
-- =============================================
CREATE PROCEDURE [dbo].[DataTransfer_cms_Photo_Add]
@categoryid int,
@albumid int,
@title nvarchar(200)='',
@filename nvarchar(200)='',
@filepath nvarchar(200)='',
@filesize int,
@orderno int,
@commentcount int,
@indexshow bit,
@flashshow bit,
@createdatetime datetime
AS
BEGIN
    INSERT INTO cms_photo([categoryid],[albumid],[title],[filename],[filepath],[filesize],[orderno],[commentcount],[indexshow],[flashshow],[createdatetime])
    VALUES(@categoryid,@albumid,@title,@filename,@filepath,@filesize,@orderno,@commentcount,@indexshow,@flashshow,@createdatetime) 

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'DataTransfer_cms_Photo_Add', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相册ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'DataTransfer_cms_Photo_Add', @level2type=N'PARAMETER',@level2name=N'@albumid'
GO
