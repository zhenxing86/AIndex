USE [zgyeycms_right]
GO
/****** Object:  StoredProcedure [dbo].[RoleGetCount]    Script Date: 2014/11/24 23:34:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		高老
-- Create date: 2010-7-30
-- Description:	获得管理员权限信息列表数量
-- =============================================
CREATE PROCEDURE [dbo].[RoleGetCount]
@site_id int,
@site_instance_id int,
@role_name nvarchar(30)
AS
BEGIN
    DECLARE @count int
    SELECT @count=count(*) FROM sac_role 
    WHERE
        site_id=CASE @site_id WHEN 0 THEN site_id ELSE @site_id END
    AND site_instance_id=CASE @site_instance_id WHEN 0 THEN site_instance_id ELSE @site_instance_id END
    AND role_name LIKE '%'+@role_name+'%'
    RETURN @count
END



GO
