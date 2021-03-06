USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_Right_GetListBySiteID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	由站点ID号得到菜单列表
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_Right_GetListBySiteID]
@siteid int
AS
BEGIN
	SELECT t1.[menuid],t1.[title],t1.[url],t1.[target],t1.[parentid],t1.[categoryid],t1.[imgpath],t1.[orderno],t1.[siteid],t1.[right_id],t2.[categorycode],t3.right_code
	FROM site_menu t1 LEFT JOIN cms_category t2 ON t1.categoryid=t2.categoryid  LEFT JOIN KWebCMS_Right..sac_right t3 on t1.right_id=t3.right_id WHERE (t1.siteid=@siteid or t1.siteid=0) and t1.menuid not in(SELECT menuid FROM site_deletemenu WHERE siteid=@siteid) ORDER BY t1.orderno 
	
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_Right_GetListBySiteID', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
