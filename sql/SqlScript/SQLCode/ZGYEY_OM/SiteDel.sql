USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteDel]    Script Date: 2014/11/24 23:34:44 ******/
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
