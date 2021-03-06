USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[SiteInstanceRightAddByOrg]    Script Date: 05/14/2013 14:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2010-12-15
-- Description:	站点实例权限添加接口
-- =============================================
CREATE PROCEDURE [dbo].[SiteInstanceRightAddByOrg]
@org_id int,
@right_code nvarchar(100),
@right_name nvarchar(100)
AS
DECLARE @siteid int
DECLARE @siteinstanceid int
SELECT @siteid=site_id,@siteinstanceid=site_instance_id 
FROM sac_site_instance
WHERE org_id=@org_id
IF @siteinstanceid>0
BEGIN
	IF NOT EXISTS(SELECT * FROM sac_site_right WHERE site_id=@siteid and site_instance_id=@siteinstanceid and right_code=@right_code)
	BEGIN
		INSERT INTO sac_site_right
		(site_id,site_instance_id,right_code,right_name)
		VALUES
		(@siteid,@siteinstanceid,@right_code,@right_name)
		RETURN @@IDENTITY
	END
	ELSE
	BEGIN
		RETURN (-1)
	END
END
GO
