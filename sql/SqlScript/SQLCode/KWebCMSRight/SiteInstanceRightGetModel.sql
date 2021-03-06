USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRightGetModel]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRightGetModel]
@right_id int
AS
        SELECT right_id,a.site_id,a.site_instance_id,
      right_name,right_code,site_instance_name,site_name
        FROM sac_site_right a 
        left join sac_site_instance b on a.site_instance_id=b.site_instance_id 
        left join sac_site c on a.site_id=c.site_id 
        WHERE
        right_id=@right_id
GO
