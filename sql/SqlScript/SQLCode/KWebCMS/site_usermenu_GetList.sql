USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_usermenu_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-14
-- Description:	获取用户菜单列表
-- =============================================
CREATE PROCEDURE [dbo].[site_usermenu_GetList]
@userid int,
@siteid int
AS
BEGIN
	SELECT title,menuid,parentid FROM site_menu 
	WHERE menuid in (SELECT [menuid] FROM site_usermenu WHERE userid=@userid and siteid=@siteid) 
	ORDER BY parentid asc,orderno desc
END







GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_usermenu_GetList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
