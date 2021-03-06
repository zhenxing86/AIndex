USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalphoto_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[portalphoto_Add]
@photoid int
AS
BEGIN	
	IF EXISTS (SELECT * FROM portalphoto WHERE photoid=@photoid)
		RETURN 1

	DECLARE @siteid int
	SELECT @siteid=siteid FROM cms_category WHERE categoryid=(SELECT categoryid FROM cms_photo WHERE photoid=@photoid and deletetag = 1)
	IF @siteid IS NULL
		RETURN 0
	INSERT INTO portalphoto VALUES(@photoid,@siteid)

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
