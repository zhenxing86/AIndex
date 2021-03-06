USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_album_GetCount]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-06
-- Description:	获取相册数量总数
-- =============================================
CREATE PROCEDURE [dbo].[kweb_album_GetCount]
@categorycode nvarchar(10),
@siteid int
AS
BEGIN
  DECLARE @count int  
  SELECT @count=count(*) 
    FROM cms_album t1 left join cms_category t2 on t1.categoryid=t2.categoryid  
    WHERE categorycode=@categorycode AND photocount>0  
      AND t1.siteid=@siteid and t1.deletetag = 1
  RETURN @count   
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetCount', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_album_GetCount', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
