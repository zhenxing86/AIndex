USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalarticle_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-23
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[portalarticle_Add]
@contentid int
AS
BEGIN
	IF EXISTS (SELECT * FROM portalarticle WHERE contentid=@contentid)
		RETURN 1

	DECLARE @categoryid int
	DECLARE @siteid int
	SELECT @categoryid=categoryid FROM cms_content WHERE contentid=@contentid and deletetag = 1
	IF @categoryid IS NULL
		RETURN 0
	SELECT @siteid=siteid FROM cms_category WHERE categoryid=@categoryid
	IF @siteid IS NULL
		RETURN 0
	INSERT INTO portalarticle VALUES(@contentid,@siteid)

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
