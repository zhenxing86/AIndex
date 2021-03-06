USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteDel]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-7-28
-- Description:	删除站点
-- =============================================
CREATE PROCEDURE [dbo].[SiteDel]
@site_id int
AS
IF NOT EXISTS (SELECT * FROM sac_site_instance WHERE site_id=@site_id)
BEGIN
DELETE FROM
     sac_site
WHERE
    site_id=@site_id
RETURN @@ROWCOUNT
END
GO
