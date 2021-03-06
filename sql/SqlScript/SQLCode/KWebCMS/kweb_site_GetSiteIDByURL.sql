USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[kweb_site_GetSiteIDByURL]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- kweb_site_GetSiteIDByURL 'wn.zgyey.com'

CREATE PROCEDURE [dbo].[kweb_site_GetSiteIDByURL]
@sitedns nvarchar(100)
AS
BEGIN
	DECLARE @siteid int = 0
	DECLARE @status int
	SELECT @siteid=siteid,@status=status FROM site WHERE sitedns=@sitedns and status=1
	IF (@siteid IS NULL or @siteid=0)
	BEGIN
		SELECT TOP 1 @siteid=t1.siteid FROM site_domain t1 left join site t2 on t1.siteid=t2.siteid
         WHERE t2.status=1 and t1.domain=@sitedns	
	END
	ELSE
	
	IF @status=0
	BEGIN
		SET @siteid=0
	END

	RETURN Isnull(@siteid, 0)
END


GO
