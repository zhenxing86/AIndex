USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_GetMenuListByParentID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		lx
-- Create date: 2009-02-12
-- Description:	根据一级菜单获取二级菜单列表
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_GetMenuListByParentID]
@parentid int,
@siteid int

AS
BEGIN	
	SELECT [menuid],[title],[url],[target],[parentid],[categoryid],[imgpath],[orderno],right_id FROM site_menu where  (siteid=@siteid or siteid=0)  and parentid=@parentid order by orderno asc
	
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_GetMenuListByParentID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
