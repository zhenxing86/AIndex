USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themelist_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-014
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[site_themelist_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM site_themelist
	RETURN @count
END



GO
