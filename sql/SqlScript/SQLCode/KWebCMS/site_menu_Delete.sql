USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[site_menu_Delete]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		hanbin
-- Create date: 2009-01-13
-- Description:	删除菜单
-- =============================================
CREATE PROCEDURE [dbo].[site_menu_Delete]
@menuid int,
@siteid int
AS
BEGIN
	BEGIN TRANSACTION

	DECLARE @oldsiteid int
	DECLARE @parentid int
	DECLARE @oldcategoryid int
	DECLARE @title nvarchar(20)
	DECLARE @right_id int
	SELECT @oldsiteid=siteid,@parentid=parentid,@oldcategoryid=categoryid,@title=title,@right_id=right_id FROM site_menu WHERE menuid=@menuid

	IF EXISTS(SELECT * FROM site_menu WHERE parentid=@menuid and @oldsiteid<>0)
	BEGIN
		COMMIT TRANSACTION
	    RETURN (-2)		
	END
	IF(@oldsiteid=0)
	BEGIN
		INSERT INTO site_deletemenu(menuid,siteid) VALUES(@menuid,@siteid)
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT * FROM site_menu WHERE parentid=@parentid and title=@title and siteid=0)
		BEGIN
			DECLARE @newcategoryid int
			SELECT TOP(1) @newcategoryid=categoryid FROM site_menu WHERE parentid=@parentid and title=@title and siteid=0
			IF(@oldcategoryid>0)
			BEGIN
				DECLARE @oldcategorycode nvarchar(20)
				DECLARE @categorysiteid int
				SELECT @oldcategorycode=categorycode,@categorysiteid=siteid FROM cms_category WHERE categoryid=@oldcategoryid
				IF(@oldcategorycode=(SELECT categorycode FROM cms_category WHERE categoryid=@newcategoryid))
				BEGIN
					IF(@categorysiteid=0)
					BEGIN
						UPDATE cms_content SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid
						UPDATE cms_contentattachs SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid
						UPDATE cms_album SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid
						UPDATE cms_photo SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid	
						DELETE site_menu WHERE menuid=@menuid
					END
					ELSE
					BEGIN
						UPDATE cms_content SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid
						UPDATE cms_contentattachs SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid
						UPDATE cms_album SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid
						UPDATE cms_photo SET categoryid=@newcategoryid WHERE categoryid=@oldcategoryid
						DELETE cms_category WHERE categoryid=@oldcategoryid
						DELETE site_menu WHERE menuid=@menuid
					END
				END
				ELSE
				BEGIN
					DELETE site_menu WHERE [menuid] = @menuid
				END
			END
			ELSE
			BEGIN
				DELETE site_menu WHERE [menuid] = @menuid
			END
		END
		ELSE
		BEGIN
			DELETE site_menu WHERE [menuid] = @menuid
		END
	END
	IF EXISTS(SELECT * FROM site t1 INNER JOIN  KWebCMS_Right..sac_site_instance t2 on t1.org_id=t2.org_id WHERE t1.siteid=@siteid) AND @right_id>0
	BEGIN			
		DELETE t4 FROM site t1 INNER JOIN  KWebCMS_Right..sac_site_instance t2 on t1.org_id=t2.org_id INNER JOIN KWebCMS_Right..sac_role t3 ON t2.site_instance_id=t3.site_instance_id INNER JOIN KWebCMS_Right..sac_role_right t4 ON t3.role_id=t4.role_id WHERE t1.siteid=@siteid and (t3.role_name='管理员' or t3.role_name='园长') and right_id=@right_id
	END


--	EXEC site_usermenu_DeleteByMenuID @menuid

	IF @@ERROR <> 0 
	BEGIN 
		ROLLBACK TRANSACTION
	   RETURN(-1)
	END
	ELSE
	BEGIN
		COMMIT TRANSACTION
	   RETURN (1)
	END
END



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'幼儿园ID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'PROCEDURE',@level1name=N'site_menu_Delete', @level2type=N'PARAMETER',@level2name=N'@siteid'
GO
