USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_SearchGetCountByArea]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		hanbin
-- Create date: 2009-12-03
-- Description:	根据地区搜索幼儿园
-- =============================================
CREATE PROCEDURE [dbo].[site_SearchGetCountByArea]
@province int,
@city int
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM site WHERE provice=@province AND (provice=@city OR city=@city) 
	RETURN @count
END



GO
