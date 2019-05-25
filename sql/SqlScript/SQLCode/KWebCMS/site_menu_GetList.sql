USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_GetList]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	得到菜单列表
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_GetList]
AS
BEGIN
	SELECT [menuid],[title],[url],[target],[parentid],[categoryid],[imgpath],[orderno] FROM site_menu
END




GO
