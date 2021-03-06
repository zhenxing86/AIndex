USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_parentid_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		wuzy
-- Create date: 2010-08-28
-- Description:	修改菜单所属父级
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_parentid_Update]
@menuid int,
@parentid int
AS
BEGIN
	DECLARE @siteid int
	SELECT @siteid=siteid FROM site_menu WHERE menuid=@menuid
	IF(@siteid=0)
	BEGIN
		RETURN -2
	END
	UPDATE site_menu 
	SET parentid=@parentid
	WHERE [menuid] = @menuid

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
