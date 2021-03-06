USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RoleGetModel]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-8-14
-- Description:	获取指定角色
-- =============================================
CREATE PROCEDURE [dbo].[RoleGetModel]
@role_id int
AS
BEGIN    
	SELECT sac_site_instance.org_id,sac_role.site_id,sac_role.site_instance_id,
           role_name,site_name,site_instance_name
    FROM sac_role
    INNER JOIN sac_site ON sac_role.site_id=sac_site.site_id
    INNER JOIN sac_site_instance ON sac_role.site_instance_id=sac_site_instance.site_instance_id
    WHERE [role_id]=@role_id
END
GO
