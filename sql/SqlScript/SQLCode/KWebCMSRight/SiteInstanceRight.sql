USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRight]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRight]
@org_id int
AS
SELECT right_id,right_code FROM sac_site_right
INNER JOIN sac_site_instance ON
sac_site_right.site_id=sac_site_right.site_id AND
(sac_site_instance.site_instance_id=sac_site_right.site_instance_id or sac_site_right.site_instance_id=0)
WHERE org_id=@org_id
GO
