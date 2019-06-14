USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_usermenu_DeleteByMenuID]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-15
-- Description:	删除菜单
-- =============================================
CREATE PROCEDURE [dbo].[site_usermenu_DeleteByMenuID]
@menuid int
AS
BEGIN
	DELETE site_usermenu WHERE menuid=@menuid

	IF @@ERROR <> 0 
	BEGIN	
	   RETURN(-1)
	END
	ELSE
	BEGIN
	   RETURN (1)
	END
END




GO
