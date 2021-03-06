USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_content_IsPageing]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-02-03
-- Description:	IsPageing
-- =============================================
CREATE PROCEDURE [dbo].[cms_content_IsPageing]
@contentid int
AS
BEGIN
	DECLARE @ispageing bit
	SELECT @ispageing=ispageing FROM cms_content WHERE contentid=@contentid and deletetag = 1
	IF @ispageing = 1
	BEGIN
		RETURN @ispageing
	END
	ELSE
	BEGIN
		RETURN 0
	END
END

GO
