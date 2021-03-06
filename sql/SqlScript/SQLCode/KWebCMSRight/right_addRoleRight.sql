USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[right_addRoleRight]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-9-2
-- Description:	给园长和管理员添加权限
-- =============================================
CREATE PROCEDURE [dbo].[right_addRoleRight] 
@right_id int,
@org_id int
AS
DECLARE @result1 int
DECLARE @result2 int
SET @result1=ISNULL((SELECT s1.role_id 
FROM sac_role s1
INNER JOIN sac_site_instance s2 ON s1.site_instance_id=s2.site_instance_id
WHERE role_name='管理员' AND s2.org_id=@org_id),0)

SET @result2=ISNULL((SELECT s1.role_id 
FROM sac_role s1
INNER JOIN sac_site_instance s2 ON s1.site_instance_id=s2.site_instance_id
WHERE role_name='园长' AND s2.org_id=@org_id),0)

IF @result2!=0
BEGIN
	IF NOT EXISTS(SELECT * FROM sac_role_right WHERE role_id=@result2 and right_id=@right_id)
	BEGIN
		 INSERT INTO sac_role_right(role_id,right_id)
		 VALUES(@result2,@right_id)
	END
END

IF @result1!=0
BEGIN
	IF NOT EXISTS(SELECT * FROM sac_role_right WHERE role_id=@result1 and right_id=@right_id)
	BEGIN
		 INSERT INTO sac_role_right(role_id,right_id)
		 VALUES(@result1,@right_id)
	END
END


IF(@@ERROR<>0)
BEGIN
	RETURN 1
END
ELSE
BEGIN
	RETURN 0
END
GO
