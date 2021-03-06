USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalcontent_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-03
-- Description:	Add
-- =============================================
CREATE PROCEDURE [dbo].[portalcontent_Add]
@contentid int,
@categorycode nvarchar(20)
AS
BEGIN
	IF EXISTS(SELECT * FROM portalcontent WHERE contentid=@contentid)
	BEGIN
		RETURN 1
	END
	

	DECLARE @categoryid int
	DECLARE @siteid int
	SELECT @categoryid=categoryid FROM cms_content WHERE contentid=@contentid and deletetag = 1
	IF @categoryid IS NULL
		RETURN 0
	SELECT @siteid=siteid FROM cms_category WHERE categoryid=@categoryid
	IF @siteid IS NULL
		RETURN 0

	INSERT INTO portalcontent VALUES(@contentid,@siteid,@categorycode)

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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分类编号' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'portalcontent_Add', @level2type=N'PARAMETER',@level2name=N'@categorycode'
GO
