USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_GetModel]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	得到菜单实体
-- =============================================
Create PROCEDURE [dbo].[site_menu_GetModel]
@menuid int
AS
BEGIN
	SELECT * FROM site_menu WHERE [menuid] = @menuid
END



GO
