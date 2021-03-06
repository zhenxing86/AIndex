USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_GetPeriodicalModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		wuzy
-- Create date: 2009-01-20
-- Description:	获取期刊封面
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_GetPeriodicalModel]
@categoryid int,
@siteid int
AS
BEGIN
	SELECT TOP 1 contentid,categoryid,content,title,titlecolor,author,createdatetime,searchkey,searchdescription,browsertitle,commentcount,orderno,commentstatus,ispageing,status
	FROM cms_content
	WHERE categoryid=@categoryid and orderno=-1 and siteid=@siteid and deletetag = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetPeriodicalModel', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_content_GetPeriodicalModel', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
