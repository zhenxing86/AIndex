USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_themesetting_Update]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
-- =============================================
-- Author:		hanbin
-- Create date: 2009-06-02
-- Description:	更新模板
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_themesetting_Update]
@userid int,
@themeid int
AS
BEGIN
	UPDATE site_themesetting SET themeid=@themeid
	WHERE siteid=(SELECT siteid FROM site_user WHERE userid=@userid)

	IF @@ERROR <> 0	
	BEGIN
		RETURN 0
	END
	ELSE
	BEGIN
		RETURN 1
	END
END



GO
