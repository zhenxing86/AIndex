USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_themelist_GetCountByTitle]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-11-27
-- Description:	GetCount
-- =============================================
CREATE PROCEDURE [dbo].[site_themelist_GetCountByTitle]
@title nvarchar(50)
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM site_themelist WHERE title LIKE '%'+@title+'%'
	RETURN @count
END



GO
