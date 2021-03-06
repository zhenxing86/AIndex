USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_GetParentMenuList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-12
-- Description:	获取一级菜单列表
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_GetParentMenuList]
@siteid int,
@userid int
AS
BEGIN	
	SELECT [menuid],[title],[url],[target],[parentid],[categoryid],[imgpath],[orderno] FROM site_menu 
	WHERE menuid in (SELECT [menuid] FROM site_usermenu WHERE userid=@userid and siteid=@siteid) and parentid=0
	ORDER BY orderno asc
END





GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_GetParentMenuList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
