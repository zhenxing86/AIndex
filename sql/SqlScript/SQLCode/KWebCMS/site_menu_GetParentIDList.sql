USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_GetParentIDList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-12
-- Description:	获取父分类ID号
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_GetParentIDList]
@siteid int
AS
BEGIN
	select menuid,title from site_menu where (siteid=@siteid or siteid=0) and menuid not in(SELECT menuid FROM site_deletemenu WHERE siteid=@siteid) order by orderno
END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_GetParentIDList', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
