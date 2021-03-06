USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[role_singleInfo]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		张启平
-- Create date: 2010-8-2
-- Description:	获取角色基本信息
-- =============================================
CREATE PROCEDURE [dbo].[role_singleInfo] 
@role_id int
AS
SELECT
    role_id,r1.site_id,r1.site_instance_id,
    role_name,site_name,site_instance_name
FROM
    sac_role r1
INNER JOIN sac_site ON r1.site_id=sac_site.site_id
INNER JOIN sac_site_instance ON r1.site_instance_id=sac_site_instance.site_instance_id
WHERE role_id=@role_id
GO
