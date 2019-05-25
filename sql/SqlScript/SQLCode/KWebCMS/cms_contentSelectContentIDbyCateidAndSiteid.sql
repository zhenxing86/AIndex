USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentSelectContentIDbyCateidAndSiteid]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		liaoxin
-- Create date:2010-8-19
-- Description:	根据栏目ID和站点ID 查询内容ID
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentSelectContentIDbyCateidAndSiteid]
	@siteid int,@categoryid int
AS
BEGIN
  select * from cms_content where categoryid=@categoryid and siteid=@siteid and deletetag = 1
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentSelectContentIDbyCateidAndSiteid', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'cms_contentSelectContentIDbyCateidAndSiteid', @level2type=N'PARAMETER',@level2name=N'@categoryid'
GO
