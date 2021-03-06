USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_GetSiteIDAndSiteUrlByUserID]    Script Date: 2014/11/24 23:13:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2010-01-09
-- Description:	获取站点ID和网址
-- =============================================
CREATE PROCEDURE [dbo].[kweb_GetSiteIDAndSiteUrlByUserID]
@userid int
AS
BEGIN
	SELECT t1.siteid,t1.sitedns FROM site t1 left join site_user t2 on t1.siteid=t2.siteid
WHERE t2.userid=@userid
END



GO
