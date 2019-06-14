USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_usermenu_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-14
-- Description:	删除菜单
-- =============================================
CREATE PROCEDURE [dbo].[site_usermenu_Delete]
@userid int,
@menuid int
AS
BEGIN
	DELETE site_usermenu WHERE userid=@userid and menuid=@menuid

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
