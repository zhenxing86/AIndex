USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[MH_site_GetPerfectCount]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		hanbin
-- ALTER date: 2009-03-26
-- Description:	获取优秀幼儿园列表数量
-- =============================================
CREATE PROCEDURE [dbo].[MH_site_GetPerfectCount]
AS
BEGIN
	DECLARE @count int
--	SELECT @count=count(s.siteid) FROM site s JOIN site_config t 
--	ON s.siteid=t.siteid AND t.ispublish=1 AND s.status=1 
	RETURN 100 --@count
END













GO
