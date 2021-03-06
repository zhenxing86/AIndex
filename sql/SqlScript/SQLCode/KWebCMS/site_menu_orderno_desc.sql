USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_orderno_desc]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-15
-- Description:	指定菜单排序号 - 1
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_orderno_desc]
@menuid int
AS
BEGIN
	BEGIN TRANSACTION

	DECLARE @currentOrderNo int
	DECLARE @currentParentID int
	DECLARE @currentSiteID int
	SELECT @currentParentID=parentid,@currentOrderNo=orderno,@currentSiteID=siteid FROM site_menu WHERE menuid=@menuid

	DECLARE @NewOrderNo int
	DECLARE @NewMenuID int
	DECLARE @NewSiteID int
	SELECT TOP 1 @NewMenuID=menuid,@NewOrderNo=orderno,@NewSiteID=siteid FROM site_menu WHERE parentid=@currentParentID and (siteid=@currentSiteID or siteid=0) and orderno<@currentOrderNo ORDER BY orderno DESC

	IF @NewMenuID IS NULL OR @NewOrderNo IS NULL OR @NewSiteID=0 OR @currentSiteID=0
	BEGIN
		COMMIT TRANSACTION
		RETURN 2
	END

	update site_menu set orderno=@NewOrderNo where menuid=@menuid

	update site_menu set orderno=@currentOrderNo where menuid=@NewMenuID

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN 1
	END
END


GO
