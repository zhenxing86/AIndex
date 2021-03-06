USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[right_delRoleRight]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROCEDURE [dbo].[right_delRoleRight]
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

IF EXISTS(SELECT * FROM sac_role_right WHERE role_id=@result2 AND right_id=@right_id)
BEGIN
 DELETE FROM sac_role_right
 WHERE role_id=@result2 AND right_id=@right_id
END

IF EXISTS(SELECT * FROM sac_role_right WHERE role_id=@result1 AND right_id=@right_id)
BEGIN
 DELETE FROM sac_role_right
 WHERE role_id=@result1 AND right_id=@right_id
RETURN @@ROWCOUNT
END
ELSE
RETURN 0



GO
