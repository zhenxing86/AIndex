USE [ZGYEYCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceOrg]    Script Date: 05/14/2013 14:58:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceOrg]
@site_instance_id int
AS
SELECT sac_site_instance.org_id,site_instance_name,sac_org.org_name
FROM sac_site_instance
INNER JOIN sac_org 
ON sac_site_instance.org_id=sac_org.org_id
WHERE site_instance_id=@site_instance_id
GO
