USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_cms_contentattaches_right_GetList]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		liaoxin
-- Create date: 2010-12-15
-- Description:	获取内容权限列表
-- =============================================
CREATE PROCEDURE [dbo].[kweb_cms_contentattaches_right_GetList]
@siteid int
AS
BEGIN
	select * from cms_contentattachs_right where siteid=@siteid
END











GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_cms_contentattaches_right_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
