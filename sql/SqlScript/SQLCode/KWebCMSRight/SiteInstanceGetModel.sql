USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceGetModel]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	获取指定站点实例
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceGetModel]
@site_instance_id int
AS
BEGIN    
	SELECT [site_instance_id],I.org_id,I.site_id,site_instance_name,org_name,site_name,personalized
    FROM sac_site_instance I
    INNER JOIN sac_org ON I.org_id=sac_org.org_id
    INNER JOIN sac_site ON I.site_id=sac_site.site_id
    WHERE [site_instance_id]=@site_instance_id
END
GO
