USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[cms_contentattachs_GetModel]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-20
-- Description:	获取附件实体
-- =============================================
CREATE PROCEDURE [dbo].[cms_contentattachs_GetModel]
@contentattachsid int
AS
BEGIN
	SELECT * FROM cms_contentattachs WHERE contentattachsid=@contentattachsid
END



GO
