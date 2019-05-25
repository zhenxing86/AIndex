USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_portalarticle_GetCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-03-26
-- Description:	获取门户新闻总数
-- =============================================
CREATE PROCEDURE [dbo].[MH_portalarticle_GetCount]
AS
BEGIN
	DECLARE @count int
	SELECT @count=count(*) FROM portalarticle
	RETURN @count
END


GO
