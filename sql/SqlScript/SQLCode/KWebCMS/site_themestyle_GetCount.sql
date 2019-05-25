USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themestyle_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-04-15
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[site_themestyle_GetCount]
@themeid int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM site_themestyle WHERE themeid=@themeid
	RETURN @count
END



GO
