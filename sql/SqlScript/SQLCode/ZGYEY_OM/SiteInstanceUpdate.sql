USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceUpdate]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-8-13
-- Description:	修改站点实例
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceUpdate]
@site_instance_id int,
@org_id int,
@site_id int,
@site_instance_name nvarchar(50),
@personalized int
AS
BEGIN
	UPDATE [sac_site_instance] SET 
	org_id = @org_id,site_id = @site_id,
    site_instance_name = @site_instance_name,
    personalized=@personalized
	WHERE 
    site_instance_id=@site_instance_id 

    IF(@@ERROR<>0)
    BEGIN
	   RETURN (-1)
    END
    ELSE
    BEGIN
	   RETURN (1)
    END
END



GO
