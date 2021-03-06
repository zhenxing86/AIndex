USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[KWebCMS_GetInsideNotifyCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		hanbin
-- Create date: 2009-07-02
-- Description:	内部通知读取
-- =============================================
CREATE PROCEDURE [dbo].[KWebCMS_GetInsideNotifyCount]
AS
BEGIN
	DECLARE @count int	
	SELECT @count=count(contentid) FROM cms_content 
	WHERE categoryid IN (SELECT categoryid FROM cms_category WHERE siteid=18 AND categorycode='nbtz') and deletetag = 1
	RETURN @count
END

GO
