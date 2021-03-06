USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_Right_Add]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		wuzy
-- Create date: 2009-01-13
-- Description:	菜单权限
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_Right_Add]
@menuid int,
@rightcode nvarchar(100),
@siteid int
AS
BEGIN TRANSACTION
DECLARE @right_id INT
DECLARE @menusiteid INT
DECLARE @parentid INT
DECLARE @title nvarchar(100)
DECLARE @site_instance_id INT
SELECT @title=title,@parentid=parentid,@menusiteid=siteid,@right_id=right_id FROM site_menu WHERE menuid=@menuid
SELECT @site_instance_id=t2.site_instance_id FROM site t1 INNER JOIN KWebCMS_Right..sac_site_instance t2 ON t1.org_id=t2.org_id  WHERE t2.site_id=1 and t1.siteid=@siteid
DECLARE @manage_role_id int
DECLARE @principal_role_id int
SELECT @manage_role_id=role_id from kwebcms_right..sac_role where site_instance_id=@site_instance_id and role_name='管理员' and site_id=1
SELECT @principal_role_id=role_id from kwebcms_right..sac_role where site_instance_id=@site_instance_id and role_name='园长' and site_id=1

IF(@menusiteid<>0)
BEGIN
	IF(@right_id is null or @right_id=0)
	BEGIN
		DECLARE @new_right_id int
		IF(@parentid=0)
		BEGIN
			INSERT INTO KWebCMS_Right..sac_right(site_id,site_instance_id,up_right_id,right_name,right_code)
			VALUES(1,@site_instance_id,1,@title,@rightcode)
			SET @new_right_id=@@IDENTITY
			UPDATE site_menu SET right_id=@new_right_id WHERE menuid=@menuid
		END
		ELSE
		BEGIN
			DECLARE @parent_right_id int
			SELECT @parent_right_id=right_id FROM site_menu WHERE menuid=@parentid
			INSERT INTO KWebCMS_Right..sac_right(site_id,site_instance_id,up_right_id,right_name,right_code)
			VALUES(1,@site_instance_id,@parent_right_id,@title,@rightcode)
			SET @new_right_id=@@IDENTITY
			UPDATE site_menu SET right_id=@new_right_id WHERE menuid=@menuid
		END
		INSERT INTO kwebcms_right..sac_role_right(role_id,right_id)VALUES(@manage_role_id,@new_right_id)
		INSERT INTO kwebcms_right..sac_role_right(role_id,right_id)VALUES(@principal_role_id,@new_right_id)
	END
	ELSE
	BEGIN
		IF(@parentid=0)
		BEGIN
			UPDATE KWebCMS_Right..sac_right SET right_code=@rightcode,up_right_id=1 WHERE right_id=@right_id
		END
		ELSE
		BEGIN
			DECLARE @sparent_right_id int
			SELECT @sparent_right_id=right_id FROM site_menu WHERE menuid=@parentid
			UPDATE KWebCMS_Right..sac_right SET right_code=@rightcode,up_right_id=@sparent_right_id WHERE right_id=@right_id
		END
		IF NOT EXISTS(SELECT * FROM kwebcms_right..sac_role_right WHERE role_id=@manage_role_id and right_id=@right_id)
		BEGIN
			INSERT INTO kwebcms_right..sac_role_right(role_id,right_id)VALUES(@manage_role_id,@right_id)
		END
		IF NOT EXISTS(SELECT * FROM kwebcms_right..sac_role_right WHERE role_id=@principal_role_id and right_id=@right_id)
		BEGIN
			INSERT INTO kwebcms_right..sac_role_right(role_id,right_id)VALUES(@principal_role_id,@right_id)
		END
	END
END
ELSE
BEGIN
	IF NOT EXISTS(SELECT * FROM kwebcms_right..sac_role_right WHERE role_id=@manage_role_id and right_id=@right_id)
	BEGIN
		INSERT INTO kwebcms_right..sac_role_right(role_id,right_id)VALUES(@manage_role_id,@right_id)
	END
	IF NOT EXISTS(SELECT * FROM kwebcms_right..sac_role_right WHERE role_id=@principal_role_id and right_id=@right_id)
	BEGIN
		INSERT INTO kwebcms_right..sac_role_right(role_id,right_id)VALUES(@principal_role_id,@right_id)
	END
END


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
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_Right_Add', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
