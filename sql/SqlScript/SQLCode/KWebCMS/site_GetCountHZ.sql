USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_GetCountHZ]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-03
-- Description:	获取站点数量
-- =============================================
create PROCEDURE [dbo].[site_GetCountHZ]
AS
BEGIN
	DECLARE @count int
	SET @count=0
	SELECT @count=count(*) FROM site
	RETURN @count
END




GO
