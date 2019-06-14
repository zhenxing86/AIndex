USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[portalphoto_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-25
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[portalphoto_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM portalphoto p,cms_photo c
	WHERE p.photoid=c.photoid and c.deletetag = 1
	RETURN @count
END

GO
