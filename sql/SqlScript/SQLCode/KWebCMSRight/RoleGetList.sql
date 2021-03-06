USE [KWebCMS_Right]
GO
/****** Object:  StoredProcedure [dbo].[RoleGetList]    Script Date: 05/14/2013 14:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		高老
-- Create date: 2010-7-30
-- Description:	获得管理员权限信息列表
-- =============================================
CREATE PROCEDURE [dbo].[RoleGetList]
@site_id int,
@site_instance_id int,
@role_name nvarchar(30),
@page int,
@size int
AS
BEGIN	
    IF(@site_instance_id=-1)
    SELECT  [role_id],a.site_id,a.site_instance_id,
               role_name,site_name,site_instance_name
    FROM sac_role a 
             left join sac_site b 
             on a.site_id=b.site_id 
             left join sac_site_instance c 
             on a.site_instance_id=c.site_instance_id
    WHERE a.site_id=@site_id AND personalized=0
    IF(@site_instance_id=-2)
    SELECT  [role_id],a.site_id,a.site_instance_id,
               role_name,site_name,site_instance_name
    FROM sac_role a 
             left join sac_site b 
             on a.site_id=b.site_id 
             left join sac_site_instance c 
             on a.site_instance_id=c.site_instance_id
    WHERE a.site_id=@site_id
    ELSE
	IF(@page>1)
    BEGIN
        DECLARE @count int
        DECLARE @ignore int
        
        SET @count=@page*@size
        SET @ignore=@count-@size
        
        DECLARE @temptable TABLE
        (
            row int identity(1,1) primary key,
            temp_roleid int
        )
        
        SET ROWCOUNT @count
        INSERT INTO @temptable
        SELECT [role_id] FROM sac_role 
        WHERE
        site_id=CASE @site_id WHEN 0 THEN site_id ELSE @site_id END
    AND site_instance_id=CASE @site_instance_id WHEN 0 THEN site_instance_id ELSE @site_instance_id END
    AND role_name like '%'+ @role_name +'%'
        
        SET ROWCOUNT @size
        SELECT [role_id],a.site_id,a.site_instance_id,
               role_name,site_name,site_instance_name
        FROM sac_role a 
             left join sac_site b 
             on a.site_id=b.site_id 
             left join sac_site_instance c 
             on a.site_instance_id=c.site_instance_id,@temptable
        WHERE [role_id]=temp_roleid AND row>@ignore
    END
    ELSE IF(@page=1)
    BEGIN
        SET ROWCOUNT @size
        SELECT [role_id],a.site_id,a.site_instance_id,
               role_name,site_name,site_instance_name
        FROM sac_role a 
             left join sac_site b 
             on a.site_id=b.site_id 
             left join sac_site_instance c 
             on a.site_instance_id=c.site_instance_id
        WHERE
        a.site_id=CASE @site_id WHEN 0 THEN a.site_id ELSE @site_id END
    AND a.site_instance_id=CASE @site_instance_id WHEN 0 THEN a.site_instance_id ELSE @site_instance_id END
    AND role_name like '%'+ @role_name +'%'
    END
    ELSE
    BEGIN
        SELECT [role_id],a.site_id,a.site_instance_id,
               role_name,site_name,site_instance_name
        FROM sac_role a 
             left join sac_site b 
             on a.site_id=b.site_id 
             left join sac_site_instance c 
             on a.site_instance_id=c.site_instance_id
        WHERE
        a.site_id=CASE @site_id WHEN 0 THEN a.site_id ELSE @site_id END
    AND a.site_instance_id=CASE @site_instance_id WHEN 0 THEN a.site_instance_id ELSE @site_instance_id END
    AND role_name like '%'+ @role_name +'%'
    END
END
GO
