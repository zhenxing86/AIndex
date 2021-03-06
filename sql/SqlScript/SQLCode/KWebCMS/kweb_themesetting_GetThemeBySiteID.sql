USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_themesetting_GetThemeBySiteID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-06
-- Description:	获取网站皮肤
-- =============================================
CREATE PROCEDURE [dbo].[kweb_themesetting_GetThemeBySiteID]
@siteid int
AS
BEGIN

	declare @city int	
	select @city=city from site where siteid=@siteid

	SELECT title,@city as city FROM site_themesetting s join site_themelist l ON s.themeid=l.themeid WHERE s.siteid=@siteid
END




GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'kweb_themesetting_GetThemeBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
