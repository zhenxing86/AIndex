USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_imgcontent_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[cms_imgcontent_GetCount]
@categoryid int
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM cms_imgcontent 
	WHERE categoryid=@categoryid and deletetag = 1
    RETURN @count
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_imgcontent_GetCount', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
