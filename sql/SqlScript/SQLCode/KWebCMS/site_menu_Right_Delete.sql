USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_Right_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		wuzy
-- Create date: 2009-01-13
-- Description:	菜单权限
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_Right_Delete]
@siteid int
AS
	BEGIN TRANSACTION
	DECLARE @site_instance_id INT
	SELECT @site_instance_id=t2.site_instance_id FROM site t1 INNER JOIN KWebCMS_Right..sac_site_instance t2 ON t1.org_id=t2.org_id  WHERE t2.site_id=1 and t1.siteid=@siteid
	DECLARE @manage_role_id int
	DECLARE @principal_role_id int
	SELECT @manage_role_id=role_id from kwebcms_right..sac_role where site_instance_id=@site_instance_id and role_name='管理员' and site_id=1
	SELECT @principal_role_id=role_id from kwebcms_right..sac_role where site_instance_id=@site_instance_id and role_name='园长' and site_id=1

	DELETE kwebcms_right..sac_role_right WHERE role_id=@manage_role_id
	DELETE kwebcms_right..sac_role_right WHERE role_id=@principal_role_id

	IF @@ERROR <> 0 
	BEGIN	
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN 1
	END

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_Right_Delete', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
