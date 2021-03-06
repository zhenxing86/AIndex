USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_themelist_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	GetList
--exec MH_site_themelist_GetCount 1
--select * from site_themelist
--update site_themelist set theme_category_id=1
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_themelist_GetCount]
@themetype int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM site_themelist WHERE siteid=0 AND status=1 and theme_category_id=@themetype	
	RETURN @count
END



GO
