USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themesetting_GetTheme2]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-16
-- Description:	获取站点的houtai模板名
-- =============================================
create  PROCEDURE [dbo].[site_themesetting_GetTheme2]
@siteid int
AS
BEGIN
	select title from site_themesetting as a inner join site_themelist as b on a.themeid2=b.themeid  where  a.siteid=@siteid and b.siteid=-1
END


GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_themesetting_GetTheme2', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
