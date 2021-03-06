USE [KWebCMS]
GO
/****** Object:  StoredProcedure [dbo].[sitetheme_del]    Script Date: 2014/11/24 23:13:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		gaolao
-- Create date: 2011-4-7
-- Description:	删除个性化站点
-- =============================================
CREATE PROCEDURE [dbo].[sitetheme_del] 
@theme_id int,
@site_id int,
@org_id int,
@right_id int
AS
BEGIN TRANSACTION

DECLARE @errorSun int
SET @errorSun=0

DECLARE @result1 int
DECLARE @result2 int
SET @result1=ISNULL((SELECT s1.role_id 
FROM kWebCMS_Right..sac_role s1
INNER JOIN kWebCMS_Right..sac_site_instance s2 ON s1.site_instance_id=s2.site_instance_id
WHERE role_name='管理员' AND s2.org_id=@org_id),0)

SET @result2=ISNULL((SELECT s1.role_id 
FROM kWebCMS_Right..sac_role s1
INNER JOIN kWebCMS_Right..sac_site_instance s2 ON s1.site_instance_id=s2.site_instance_id
WHERE role_name='园长' AND s2.org_id=@org_id),0)

IF @result2!=0
BEGIN
	IF NOT EXISTS(SELECT * FROM kWebCMS_Right..sac_role_right WHERE role_id=@result2 and right_id=@right_id)
	BEGIN
		 INSERT INTO kWebCMS_Right..sac_role_right(role_id,right_id)
		 VALUES(@result2,@right_id)
	END
END

IF @result1!=0
BEGIN
	IF NOT EXISTS(SELECT * FROM kWebCMS_Right..sac_role_right WHERE role_id=@result1 and right_id=@right_id)
	BEGIN
		 INSERT INTO kWebCMS_Right..sac_role_right(role_id,right_id)
		 VALUES(@result1,@right_id)
	END
END
SET @errorSun=@errorSun+@@error

update kwebcms..site_themesetting set themeid=71 where siteid=@site_id
SET @errorSun=@errorSun+@@error

DELETE FROM site_themelist WHERE themeid=@theme_id
SET @errorSun=@errorSun+@@error

IF @errorSun<>0
	BEGIN
        ROLLBACK TRANSACTION
		RETURN 0
	END
	ELSE
	BEGIN
        COMMIT TRANSACTION
		RETURN 1
	END



GO
