USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_photo_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-20
-- Description:	获取图片实体
-- =============================================
CREATE PROCEDURE [dbo].[cms_photo_GetModel]
@photoid int
AS
BEGIN
	SELECT * FROM cms_photo WHERE photoid=@photoid and deletetag = 1
END

GO
